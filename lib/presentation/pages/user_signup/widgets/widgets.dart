import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/constants.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/user_signup_two.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class SignUpWidgets {
  static Text signInNavigate() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "Already have an account? ",
            style: TextStyle(
              color: kGray,
            ),
          ),
          TextSpan(
            text: 'Sign In.',
            style: TextStyle(color: kBlack),
          ),
        ],
      ),
    );
  }

  static Future<dynamic> validateEmail(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text(
            'Verification',
            style: TextStyle(
              fontVariations: fontWeightW600,
            ),
          ),
          content: const Text(
              'A 6 - Digit OTP has been sent to your email address, enter it below to continue'),
          actions: [
            const CustomTxtFormField(hintText: 'OTP'),
            kHeight(20),
            CustomButton(
              buttonText: 'Continue',
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const UserSignUpPageTwo(),
                ));
              },
            ),
          ],
        );
      },
    );
  }
}
