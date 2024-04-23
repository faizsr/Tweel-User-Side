import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/repository/chat_repo/chat_repo.dart';

part 'get_chat_event.dart';
part 'get_chat_state.dart';

class GetChatBloc extends Bloc<GetChatEvent, GetChatState> {
  GetChatBloc() : super(UserInitial()) {
    on<FetchAllUserChatsEvent>(fetchAllUsersEvent);
  }

  FutureOr<void> fetchAllUsersEvent(
      FetchAllUserChatsEvent event, Emitter<GetChatState> emit) async {
    emit(UserChatsFetchingLoadingState());
    List<ChatModel> chats = await ChatRepo.fetchUserChats();
    if (chats.isNotEmpty) {
      Set<String> usernames = {};
      List<UserModel> chatUsersList = [];
      debugPrint('Total chats: ${chats.length}');
      for (int i = 0; i < chats.length; i++) {
        if (chats[i].sender.username == event.currentUsername) {
          if (!usernames.contains(chats[i].receiver.username)) {
            usernames.add(chats[i].receiver.username ?? '');
            if (!chatUsersList.contains(chats[i].receiver)) {
              chatUsersList.add(chats[i].receiver);
            }
          }
        }
        if (chats[i].receiver.username == event.currentUsername) {
          if (!usernames.contains(chats[i].sender.username)) {
            usernames.add(chats[i].sender.username ?? '');
            if (!chatUsersList.contains(chats[i].sender)) {
              chatUsersList.add(chats[i].sender);
            }
          }
        }
      }
      debugPrint('Total chat users: ${chatUsersList.length}');
      debugPrint('Total string usernames: ${usernames.length}');
      emit(UserChatsFetchingSuccessState(
          chats: chats, chatUsersList: chatUsersList));
    } else {
      emit(UserChatsFetchingErrorState());
    }
  }
}
