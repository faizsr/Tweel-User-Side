import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<ChatModel> messages = [];
  ChatBloc() : super(ChatInitial()) {
    on<AddNewMessageEvent>(addNewMessageEvent);
    on<AddInitialMessageEvent>(addInitialMessageEvent);
    on<ClearMessageOnLogoutEvent>(clearMessageOnLogoutEvent);
  }

  FutureOr<void> addNewMessageEvent(
      AddNewMessageEvent event, Emitter<ChatState> emit) {
    messages.add(event.chatModel);
    debugPrint('Message using bloc: ${messages.length}');
    messages.sort((a, b) => b.sendAt.compareTo(a.sendAt));
    if (messages.isNotEmpty) {
      emit(ChatAddedState(messageList: messages));
    }
  }

  FutureOr<void> addInitialMessageEvent(
      AddInitialMessageEvent event, Emitter<ChatState> emit) {
    messages.addAll(event.messageList);
    debugPrint('Message using bloc: ${messages.length}');
    messages.sort((a, b) => b.sendAt.compareTo(a.sendAt));
    emit(ChatAddedState(messageList: messages));
  }

  FutureOr<void> clearMessageOnLogoutEvent(
      ClearMessageOnLogoutEvent event, Emitter<ChatState> emit) {
    messages.clear();
    debugPrint('Message using bloc: ${messages.length}');
  }
}
