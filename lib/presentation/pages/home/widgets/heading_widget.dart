import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
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
            nextScreen(context, const NotificationPage())
                .then((value) => mySystemTheme(context));
          },
          child: const Icon(Ktweel.notification_bing),
        ),
      ],
    );
  }
}
