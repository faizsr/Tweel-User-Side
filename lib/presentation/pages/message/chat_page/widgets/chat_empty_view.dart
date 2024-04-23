import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Chat is empty',
          style: TextStyle(
            fontSize: 18,
            fontVariations: fontWeightW700,
          ),
        ),
        kHeight(5),
        Text(
          'Be the one to break the ice.',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
