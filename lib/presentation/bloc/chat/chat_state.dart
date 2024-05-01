part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatAddedState extends ChatState {
  final List<ChatModel> messageList;

  ChatAddedState({
    required this.messageList,
  });
}

class ChatEmptyState extends ChatState {}
