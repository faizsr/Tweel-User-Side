import 'package:flutter/material.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/message/widgets/message_function.dart';
import 'package:tweel_social_media/presentation/pages/message/widgets/message_user_card.dart';

class MessageListView extends StatelessWidget {
  const MessageListView({
    super.key,
    required this.messagePageController,
    required this.chatUsersList,
    required this.messageList,
    required this.currentUser,
  });

  final ScrollController messagePageController;
  final List<UserModel> chatUsersList;
  final List<ChatModel> messageList;
  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: messagePageController,
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      itemCount: chatUsersList.length,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        UserModel chatUser = chatUsersList[index];
        ChatModel lastMessage = MessageFunctions.getLastMessage(
          currentUser,
          messageList,
          chatUser,
        );
        return MessageUserCard(
          chatUser: chatUser,
          lastMessage: lastMessage,
        );
      },
    );
  }
}
