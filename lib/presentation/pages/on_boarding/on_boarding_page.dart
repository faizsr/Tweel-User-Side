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
      child: GestureDetector(
        onVerticalDragUpdate: (dragUpdateDetails) {
          print('object');
          UserAuthStatus.saveUserinitialStatus(true);
          nextScreenRemoveUntil(context, const UserSignInPage());
        },
        child: Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: Column(
            children: [
              const Spacer(),
              const LoginAssets(),
              const Spacer(),
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
                  .shimmer(delay: 400.ms, duration: 1000.ms)
                  .shake(hz: 4, curve: Curves.easeInOutCubic)
                  .scaleXY(end: 1.1, duration: 600.ms)
                  .then(delay: 600.ms)
                  .scaleXY(end: 1 / 1.1),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget swipeDownWidget(BuildContext context) {
    return const SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Icon(Ktweel.arrow_up_ios, size: 30),
          Positioned(
            top: 20,
            child: Icon(Ktweel.arrow_up_ios, size: 20),
          ),
          Positioned(
            top: 35,
            child: Text(
              '●',
              style: TextStyle(
                fontVariations: fontWeightRegular,
                fontSize: 8,
              ),
            ),
          ),
        ],
      ),
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
