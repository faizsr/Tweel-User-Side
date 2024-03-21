import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/user_signup_one.dart';

class SignInWidgets {
  static InkWell signUpNavigate(context) {
    return InkWell(
      onTap: () => nextScreen(context, const UserSignUpPageOne()),
      child: FadeInUp(
        delay: const Duration(milliseconds: 700),
        duration: const Duration(milliseconds: 1000),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Don't have an account yet? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const TextSpan(
                text: 'Sign Up.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
