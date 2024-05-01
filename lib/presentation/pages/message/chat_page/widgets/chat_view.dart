import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/own_message_card.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/reply_card.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.messageList,
    required this.currentUser,
    required this.chatUser,
  });

  final List<ChatModel> messageList;
  final UserModel currentUser;
  final UserModel chatUser;

  @override
  Widget build(BuildContext context) {
    final filteredMessages = messageList.where((message) =>
        (message.sender.username == currentUser.username &&
            message.receiver.username == chatUser.username) ||
        (message.sender.username == chatUser.username &&
            message.receiver.username == currentUser.username));

    final groupedMessages = groupBy(filteredMessages, (ChatModel message) {
      return DateFormat('dd-MM-yyyy').format(message.sendAt);
    });

    final dates = groupedMessages.keys.toList()
      ..sort((a, b) {
        final dateA = DateFormat('dd-MM-yyyy').parse(a);
        final dateB = DateFormat('dd-MM-yyyy').parse(b);
        return dateB.compareTo(dateA);
      });

    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      physics: const ClampingScrollPhysics(),
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final date = dates[index];
        final messages = groupedMessages[date]!;
        final formattedDate = formatDate(date);
        debugPrint('Date formatted: $formattedDate');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            ...messages.map((message) {
              final isOwnMessage = isOwnMessageFn(message);
              final isReplyMessage = isReplyMessageFn(message);

              if (isOwnMessage) {
                return OwnMessageCard(message: message);
              } else if (isReplyMessage) {
                return ReplyCard(message: message);
              } else {
                return const SizedBox();
              }
            }).toList(),
          ],
        );
      },
    );
  }

  String formatDate(String date) {
    final now = DateTime.now();
    final today = DateFormat('dd-MM-yyyy').format(DateTime.now());
    final yesterday = DateFormat('dd-MM-yyyy')
        .format(DateTime(now.year, now.month, now.day - 1));

    if (date == today) {
      return 'Today';
    } else if (date == yesterday) {
      return 'Yesterday';
    }
    return date;
  }

  bool isOwnMessageFn(ChatModel message) {
    return message.sender.username == currentUser.username &&
        message.receiver.username == chatUser.username;
  }

  bool isReplyMessageFn(ChatModel message) {
    return message.receiver.username == currentUser.username &&
        message.sender.username == chatUser.username;
  }
}
