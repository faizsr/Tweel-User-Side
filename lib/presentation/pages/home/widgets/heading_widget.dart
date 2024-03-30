import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Tweel.',
          style: TextStyle(fontSize: 24),
        ),
        InkWell(
          onTap: () {
            changeSystemThemeOnPopup(
                color: isDarkMode ? dBlueGrey : lLightWhite);
            nextScreen(context, const NotificationPage())
                .then((value) => mySystemTheme(context));
          },
          child: const Icon(Ktweel.notification_bing),
        ),
      ],
    );
  }
}
