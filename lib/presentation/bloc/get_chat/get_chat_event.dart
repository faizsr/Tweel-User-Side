part of 'get_chat_bloc.dart';

@immutable
sealed class GetChatEvent {}

class FetchAllUserChatsEvent extends GetChatEvent {
  final String currentUsername;

  FetchAllUserChatsEvent({
    required this.currentUsername,
  });
}
