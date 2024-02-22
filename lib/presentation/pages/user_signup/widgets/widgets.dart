import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/constants.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_up/sign_up_bloc.dart';
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

  static Future<dynamic> validateEmail({
    BuildContext? context,
    String? email,
    String? phoneNo,
    String? fullName,
    String? accountType,
    String? password,
    String? username,
    TextEditingController? otpController,
  }) {
    final GlobalKey<FormState> formKey = GlobalKey();
    return showDialog(
      context: context!,
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
            BlocBuilder<SignUpBloc, SignUpState>(
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: CustomTxtFormField(
                    hintText: 'OTP',
                    controller: otpController,
                    validator: (val) {
                      if (val!.length < 2) {
                        return "Please enter a valid OTP";
                      }
                      if (state is UserOtpErrorState) {
                        return 'Invalid OTP';
                      }
                      return null;
                    },
                  ),
                );
              },
            ),
            kHeight(20),
            CustomButton(
              buttonText: 'Continue',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  debugPrint(otpController!.text);

                  final user = UserModel(
                    accountType: accountType,
                    username: username,
                    password: password,
                    email: email,
                    fullName: fullName,
                    phoneNumber: phoneNo,
                    otp: otpController.text,
                  );
                  debugPrint('Account type: $accountType');
                  debugPrint('Username: $username');
                  debugPrint('Password: $password');
                  debugPrint('Email: $email');
                  debugPrint('Full name: $fullName');
                  debugPrint('Phone no.: $phoneNo');
                  debugPrint('OTP: ${otpController.text}');
                  context.read<SignUpBloc>().add(UserSignUpEvent(user: user));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
