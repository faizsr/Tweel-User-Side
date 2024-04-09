import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/user_chat_page.dart';

class MessageUserCard extends StatelessWidget {
  const MessageUserCard({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: () {
        nextScreen(context, UserChatPage(user: user));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, top: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: theme.colorScheme.onSurface,
              backgroundImage: user.profilePicture == ""
                  ? Image.asset(profilePlaceholder).image
                  : NetworkImage(user.profilePicture!),
            ),
            kWidth(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName!,
                  style: const TextStyle(fontSize: 15),
                ),
                kHeight(4),
                Text(
                  'Yeah i know',
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.secondary,
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              '11.47 AM',
              style: TextStyle(
                fontSize: 12,
                color: theme.colorScheme.onSecondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
