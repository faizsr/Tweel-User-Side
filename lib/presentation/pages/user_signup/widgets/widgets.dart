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
            BlocConsumer<SignUpBloc, SignUpState>(
              listener: (context, state) {
                print('First');
                if (state is UserAlreadyExistsState) {
                  // Navigator.pop(context);
                  print('first snackbar');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User already existsssss 1'),
                    ),
                  );
                }
                if (state is EmailAlreadyExistsState) {
                  print('Second snackbar');
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('User already exists 2'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Form(
                      key: formKey,
                      child: CustomTxtFormField(
                        hintText: 'OTP',
                        controller: otpController,
                        validator: (val) {
                          if (state is UserOtpErrorState ||
                              state is UserAlreadyExistsState) {
                            return "Please enter a valid OTP";
                          }
                          if (val!.length < 2) {
                            return "Please enter a valid OTP";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            kHeight(20),
            signUpButton(formKey, otpController, accountType, username,
                password, email, fullName, phoneNo, context),
          ],
        );
      },
    );
  }

  static Widget signUpButton(
      GlobalKey<FormState> formKey,
      TextEditingController? otpController,
      String? accountType,
      String? username,
      String? password,
      String? email,
      String? fullName,
      String? phoneNo,
      BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        // if (state is UserAlreadyExistsState) {
        //   print('Third User exists');
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: SnackBar(
        //         content: Text('User name already exists 3'),
        //       ),
        //     ),
        //   );
        // }
      },
      child: CustomButton(
        buttonText: 'Sign Up',
        onPressed: () {
          if (formKey.currentState!.validate()) {
            final user = UserModel(
              accountType: accountType,
              username: username,
              password: password,
              email: email,
              fullName: fullName,
              phoneNumber: phoneNo,
              otp: otpController!.text,
            );
            context.read<SignUpBloc>().add(UserSignUpEvent(user: user));
          }
        },
      ),
    );
  }
}
