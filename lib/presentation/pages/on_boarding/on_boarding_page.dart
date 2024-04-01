// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
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
    changeSystemThemeOnPopup(color: Theme.of(context).colorScheme.surface,context: context,);
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: GestureDetector(
          onDoubleTap: () {
            UserAuthStatus.saveUserinitialStatus(true);
            nextScreenRemoveUntil(context, const UserSignInPage());
          },
          child: Column(
            children: [
              const LoginAssets(),
              kHeight(20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(text: 'A tool to help', style: thinFontStyle),
                    TextSpan(text: ' share', style: boldFontStyle),
                    TextSpan(text: '\nmoments', style: boldFontStyle),
                    TextSpan(text: ' with', style: thinFontStyle),
                    TextSpan(text: ' friends', style: boldFontStyle),
                  ],
                ),
              ),
              kHeight(10),
              const Text('Swipe up to get started.'),
              const Spacer(),
              Container(
                width: 70,
                padding: const EdgeInsets.only(bottom: 20,top: 50),
                // clipBehavior: Clip.hardEdge,
                foregroundDecoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 0.8,
                        color: Theme.of(context).colorScheme.primary),
                    left: BorderSide(
                        width: 0.8,
                        color: Theme.of(context).colorScheme.primary),
                    right: BorderSide(
                        width: 0.8,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(Ktweel.arrow_down),
                ),
              ),
              kHeight(10),
            ],
          ),
        ),
      ),
    );
  }
}

var thinFontStyle = TextStyle(
  fontFamily: mainFont,
  fontVariations: fontWeightW300,
  fontSize: 30,
);
var boldFontStyle = TextStyle(
  fontSize: 30,
  fontVariations: fontWeightW800,
  fontFamily: mainFont,
);
