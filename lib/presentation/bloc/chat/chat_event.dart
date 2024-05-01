part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class AddNewMessageEvent extends ChatEvent {
  final ChatModel chatModel;

  AddNewMessageEvent({
    required this.chatModel,
  });
}

class AddInitialMessageEvent extends ChatEvent {
  final List<ChatModel> messageList;

  AddInitialMessageEvent({
    required this.messageList,
  });
}

class ClearAllMessageEvent extends ChatEvent {}
