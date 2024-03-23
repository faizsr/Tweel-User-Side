import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class ForgotPasswordWidgets {
  static Future<dynamic> validateEmail({
    BuildContext? context,
    TextEditingController? otpController,
  }) {
    final GlobalKey<FormState> formKey = GlobalKey();
    return showDialog(
      context: context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
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
            Column(
              children: [
                Form(
                  key: formKey,
                  child: CustomTxtFormField(
                    hintText: 'OTP',
                    controller: otpController,
                    validator: (val) {
                      if (val!.length < 2) {
                        return "Please enter a valid OTP";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            kHeight(20),
            verifyOtp(formKey, otpController, context),
          ],
        );
      },
    );
  }

  static Widget verifyOtp(GlobalKey<FormState> formKey,
      TextEditingController? otpController, BuildContext context) {
    return CustomButton(
      buttonText: 'Submit',
      onPressed: () {
        if (formKey.currentState!.validate()) {}
      },
    );
  }
}
