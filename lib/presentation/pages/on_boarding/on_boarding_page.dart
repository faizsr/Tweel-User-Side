// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/presentation/pages/on_boarding/widgets/rotating_image.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    changeSystemThemeOnPopup(
      color: theme.colorScheme.surface,
      context: context,
    );
    return ColorfulSafeArea(
      color: theme.colorScheme.surface,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: GestureDetector(
          onDoubleTap: () {
            UserAuthStatus.saveUserinitialStatus(true);
            nextScreenRemoveUntil(context, const UserSignInPage());
          },
          child: Column(
            children: [
              const LoginAssets(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'A tool to help',
                      style: thinFontStyle(context),
                    ),
                    TextSpan(text: ' share', style: boldFontStyle(context)),
                    TextSpan(text: '\nmoments', style: boldFontStyle(context)),
                    TextSpan(text: ' with', style: thinFontStyle(context)),
                    TextSpan(text: ' friends', style: boldFontStyle(context)),
                  ],
                ),
              ),
              kHeight(10),
              const Text('Swipe up to get started.'),
              const Spacer(),
              swipeDownWidget(context)
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(
                    color: theme.colorScheme.onPrimaryContainer,
                    delay: 400.ms,
                    duration: 1400.ms,
                  ),
              kHeight(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget swipeDownWidget(BuildContext context) {
    return const Column(
      children: [
        Icon(Ktweel.arrow_up_ios),
        Icon(Ktweel.arrow_up_ios),
        Icon(Ktweel.arrow_up_ios),
      ],
    );
  }

  TextStyle thinFontStyle(BuildContext context) => TextStyle(
        fontFamily: mainFont,
        fontVariations: fontWeightW300,
        fontSize: 30,
        color: Theme.of(context).colorScheme.primary,
      );

  TextStyle boldFontStyle(BuildContext context) => TextStyle(
        fontSize: 30,
        fontVariations: fontWeightW800,
        fontFamily: mainFont,
        color: Theme.of(context).colorScheme.primary,
      );
}
