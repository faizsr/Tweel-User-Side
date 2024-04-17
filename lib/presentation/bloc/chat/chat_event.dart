part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class AddNewMessageEvent extends ChatEvent {
  final ChatModel chatModel;

  AddNewMessageEvent({
    required this.chatModel,
  });
}
