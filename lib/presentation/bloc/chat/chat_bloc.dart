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
}
