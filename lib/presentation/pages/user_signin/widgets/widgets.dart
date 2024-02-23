import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/user_signup_one.dart';

class SignInWidgets {
  static InkWell signUpNavigate(context) {
    return InkWell(
      onTap: () => nextScreen(context, const UserSignUpPageOne()),
      child: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "Don't have an account yet? ",
              style: TextStyle(
                color: kGray,
              ),
            ),
            TextSpan(
              text: 'Sign Up.',
              style: TextStyle(color: kBlack),
            ),
          ],
        ),
      ),
    );
  }
}
