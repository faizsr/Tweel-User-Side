import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/validations.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class SignUpTwoFieldWidget extends StatefulWidget {
  const SignUpTwoFieldWidget({
    super.key,
    required this.email,
    required this.phoneNo,
    required this.fullName,
    required this.accountType,
  });

  final String email;
  final String phoneNo;
  final String fullName;
  final String accountType;

  @override
  State<SignUpTwoFieldWidget> createState() => _SignUpTwoFieldWidgetState();
}

class _SignUpTwoFieldWidgetState extends State<SignUpTwoFieldWidget> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Username field
            CustomTxtFormField(
              hintText: 'Username',
              controller: userNameController,
              validator: (val) {
                if (val!.length < 4) {
                  return 'Username should have at least 4 characters';
                }
                if (val.endsWith('.') || val.endsWith('_')) {
                  return "Username can't end with period or underscore";
                }
                if (!RegExp(r"^(?=.{4,20}$)(?![_.])[a-zA-Z0-9._]+(?<![_.])$")
                    .hasMatch(val)) {
                  return 'Username can only user letters, numbers, underscores and periods';
                }
                return null;
              },
            ),

            // Create password field
            kHeight(20),
            CustomTxtFormField(
              hintText: 'Create password',
              controller: passWordController,
              validator: (val) {
                if (!RegExp(passowrdRegexPattern).hasMatch(val!)) {
                  return 'Passwords should be 8 characters, at least one number and one special character';
                }
                return null;
              },
            ),
            kHeight(20),

            // Confirm passowrd field
            CustomTxtFormField(
              hintText: 'Confirm password',
              controller: confirmPasswordController,
              validator: (val) {
                if (!RegExp(passowrdRegexPattern).hasMatch(val!)) {
                  return 'Passwords should be 8 characters, at least one number and one special character';
                }
                return null;
              },
            ),
            kHeight(25),

            // Sign Up button
            BlocListener<SignUpBloc, SignUpState>(
              listener: signUpListener,
              child: CustomButton(
                buttonText: 'Sign Up',
                onPressed: () {
                  if (passWordController.text ==
                      confirmPasswordController.text) {
                    if (formKey.currentState!.validate()) {
                      context
                          .read<SignUpBloc>()
                          .add(UserOtpVerificationEvent(email: widget.email));
                    }
                  } else {
                    customSnackbar(context, "Passwords doesn't match");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void signUpListener(BuildContext context, SignUpState state) {
    if (state is UserOtpSuccessState) {
      SignUpWidgets.validateEmail(
        context: context,
        fullName: widget.fullName,
        email: widget.email,
        phoneNo: widget.phoneNo,
        accountType: widget.accountType,
        otpController: otpController,
        username: userNameController.text,
        password: passWordController.text,
      );
    }
  }
}
