import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';

class MessageEmtpyViewWidget extends StatelessWidget {
  const MessageEmtpyViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Transform.rotate(
          angle: -25.0,
          child: Icon(
            Ktweel.message_text,
            size: 50,
            color: theme.colorScheme.onSecondary,
          ),
        ),
        kHeight(5),
        const Text(
          "No Messages, yet.",
          style: TextStyle(
            fontSize: 18,
            fontVariations: fontWeightW600,
          ),
        ),
        kHeight(5),
        Text(
          'No messages in your inbox, yet! Start\nchatting with people around you.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: theme.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
