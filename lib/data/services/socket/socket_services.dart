// ignore_for_file: library_prefixes

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/chat/chat_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/get_chat/get_chat_bloc.dart';

class SocketServices {
  IO.Socket socket = IO.io(
    ApiEndPoints.socketUrl,
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );

  connectSocket(String username, BuildContext context,
      ScrollController scrollController) {
    context
        .read<GetChatBloc>()
        .add(FetchAllUserChatsEvent(currentUsername: username));

    _listenMessage(context, scrollController);
    _getOnlineUsers(context);
    _makeUserActive(username);
  }

  _listenMessage(BuildContext context, ScrollController scrollController) {
    socket.on('message', (data) {
      debugPrint('Message Event Called');
      BlocProvider.of<ChatBloc>(context).add(AddNewMessageEvent(
        chatModel: ChatModel.fromJson(data),
      ));
    });
  }

  _makeUserActive(String username) {
    socket.onConnect((data) {
      debugPrint('$username has been connected');
      socket.emit('newUser', username);
    });
  }

  _getOnlineUsers(BuildContext context) {
    socket.emit('getOnlineUsers');
    socket.on('onlineUsers', (data) {
      debugPrint('Getting online users');
      for (int i = 0; i < data.length; i++) {
        String username = data[i]['username'];
        // context.read<OnlineUsersCubit>().getOnlineUsers(username);
        debugPrint(username);
      }
    });
  }

  sendMessage({
    required String message,
    required UserModel currentUser,
    required UserModel chatUser,
    required BuildContext context,
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
