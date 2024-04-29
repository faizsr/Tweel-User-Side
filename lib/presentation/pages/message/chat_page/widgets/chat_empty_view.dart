import 'package:flutter/material.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({
    super.key,
    required this.chatUser,
  });

  final UserModel chatUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "It's time to start a chat!!",
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
