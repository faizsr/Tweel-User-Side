// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/presentation/pages/on_boarding/on_boarding_page.dart';
import 'package:tweel_social_media/presentation/pages/main/main_page.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeSystemThemeOnPopup(color: Theme.of(context).colorScheme.surface,context: context,);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const Center(
        child: Text(
          'Tweel.',
          style: TextStyle(fontSize: 35),
        ),
      ),
    );
  }

  Future<void> checkUserStatus() async {
    final userOnInitial = await UserAuthStatus.isUserOnInitial();
    final userSignIn = await UserAuthStatus.getUserStatus();
    if (userOnInitial == false) {
      nextScreen(context, const OnBoardingPage());
    } else {
      if (userSignIn == false) {
        await Future.delayed(const Duration(seconds: 3));
        nextScreenRemoveUntil(context, const UserSignInPage());
      } else {
        await Future.delayed(const Duration(seconds: 3));
        nextScreenRemoveUntil(context, MainPage());
      }
    }
  }
}
