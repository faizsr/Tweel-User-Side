import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/own_message_card.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/reply_card.dart';

class ChatView extends StatefulWidget {
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
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  static DateTime returnDateAndTimeFormat(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    // var originalDate = DateFormat('MM/dd/yyyy').format(dt);
    return DateTime(dt.year, dt.month, dt.day);
  }

  // function to return date if date changes based on your local date and time
  static String groupMessageDateAndTime(String time) {
    var dt = DateTime.fromMicrosecondsSinceEpoch(int.parse(time.toString()));
    // var originalDate = DateFormat('MM/dd/yyyy').format(dt);

    final todayDate = DateTime.now();

    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String difference = '';
    final aDate = DateTime(dt.year, dt.month, dt.day);

    if (aDate == today) {
      difference = "Today";
    } else if (aDate == yesterday) {
      difference = "Yesterday";
    } else {
      difference = DateFormat.yMMMd().format(dt).toString();
    }

    return difference;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      physics: const ClampingScrollPhysics(),
      itemCount: widget.messageList.length,
      itemBuilder: (context, index) {
        final reversedIndex = widget.messageList.length - 1 - index;
        final message = widget.messageList[reversedIndex];
        bool isOwnMessage = isOwnMessageFn(message);
        bool isReplyMessage = isReplyMessageFn(message);

        return Column(
          children: [
            if (isOwnMessage) OwnMessageCard(message: message),
            if (isReplyMessage) ReplyCard(message: message),
          ],
        );
      },
    );
  }

  SizedBox dayDateWidget(String newDate, BuildContext context) {
    return SizedBox(
      height: 40,
      child: Center(
        child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              newDate,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool isOwnMessageFn(ChatModel message) {
    return message.sender.username == widget.currentUser.username &&
        message.receiver.username == widget.chatUser.username;
  }

  bool isReplyMessageFn(ChatModel message) {
    return message.receiver.username == widget.currentUser.username &&
        message.sender.username == widget.chatUser.username;
  }
}
