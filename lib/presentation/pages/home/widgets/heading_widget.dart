import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/presentation/pages/notification/notification.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Tweel.',
          style: TextStyle(fontSize: 24),
        ),
        InkWell(
          onTap: () {
            nextScreen(context, const NotificationPage());
          },
          child: const Icon(CustomIcons.notification_off_bing),
        ),
      ],
    );
  }
}
