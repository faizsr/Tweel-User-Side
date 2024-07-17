// ignore_for_file: library_prefixes

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/chat/chat_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/get_chat/get_chat_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/online_users/online_users_cubit.dart';

class SocketServices {
  BuildContext? _context;

  IO.Socket socket = IO.io(
    ApiEndPoints.socketUrl,
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );

  connectSocket(String username, BuildContext context) {
    _context = context;
    socket = IO.io(ApiEndPoints.socketUrl,
        IO.OptionBuilder().setTransports(['websocket']).build());
    if (_context != null) {
      log('From here it is calling');
      _context!.read<GetChatBloc>().add(FetchAllUserChatsEvent());
      _listenMessage(_context);
      _getOnlineUsers(_context);
      _makeUserActive(username);
    }
  }

  disconnectSocket() {
    socket.onDisconnect((data) {
      log('Is Socket Disconnected: ${socket.disconnected}');
    });
    socket.disconnect();
    socket.clearListeners();
    socket.close();
    socket.dispose();
    log('Is Socket Active: ${socket.active}');
  }

  _listenMessage(BuildContext? context) {
    socket.on('message', (data) {
      debugPrint('Message Event Called ${data['message']}');
      BlocProvider.of<ChatBloc>(context!).add(AddNewMessageEvent(
        chatModel: ChatModel.fromJson(data),
      ));
    });
  }

  _makeUserActive(String username) {
    socket.connect();
    socket.onConnect((data) {
      socket.emit('newUser', username);
      log('Is socket connected ${socket.connected}');
      log('$username has been connected');
    });
  }

  _getOnlineUsers(BuildContext? context) {
    socket.emit('getOnlineUsers');
    socket.on('onlineUsers', (data) {
      debugPrint('Getting online users ${data.length}');
      for (int i = 0; i < data.length; i++) {
        String username = data[i]['username'];
        context!.read<OnlineUsersCubit>().getOnlineUsers(username);
      }
    });
  }

  sendMessage({
    required String message,
    required UserModel currentUser,
    required UserModel chatUser,
  }) {
    debugPrint('How many times is it calling');
    var body = {
      "message": message,
      "sender": {
        "username": "${currentUser.username}",
        "_id": "${currentUser.id}"
      },
      "receiver": {
        "username": "${chatUser.username}",
        "_id": "${chatUser.id}",
      }
    };
    socket.emit(
      'message',
      jsonEncode(body),
    );
  }
}
