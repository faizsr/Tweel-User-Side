part of 'get_chat_bloc.dart';

@immutable
sealed class GetChatState {}

final class UserChatsInitial extends GetChatState {}

class UserChatsFetchingLoadingState extends GetChatState {}

class UserChatsFetchingSuccessState extends GetChatState {
  final List<ChatModel> chats;
  final List<UserModel> chatUsersList;

  UserChatsFetchingSuccessState({
    required this.chats,
    required this.chatUsersList,
  });
}

class UserChatsFetchingErrorState extends GetChatState {}
