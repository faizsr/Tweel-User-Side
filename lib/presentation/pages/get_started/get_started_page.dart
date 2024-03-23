// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/core/utils/shared_preference.dart';
import 'package:tweel_social_media/presentation/pages/get_started/widgets/rotating_image.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    changeSystemThemeOnPopup(color: isDarkMode ? dBlueGrey : dWhite);
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
                height: 100,
                width: 70,
                padding: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
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
                  child: Icon(CustomIcons.arrow_down),
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
