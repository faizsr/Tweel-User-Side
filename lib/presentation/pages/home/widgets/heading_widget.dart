import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Tweel.',
          style: TextStyle(fontSize: 24),
        ),
        Icon(CustomIcons.notification_off_bing),
      ],
    );
  }
}