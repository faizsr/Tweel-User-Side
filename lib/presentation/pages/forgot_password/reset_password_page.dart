import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/validations.dart';
import 'package:tweel_social_media/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tweel.',
          style: TextStyle(fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: mediaHeight),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
            child: Stack(
              alignment: Alignment.center,
              children: [
                signUpForm(
                  context,
                  otpController,
                  passwordController,
                  confirmPasswordController,
                  formKey,
                ),
                Positioned(
                  bottom: 0,
                  child: SignUpWidgets.signInNavigate(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpForm(
    BuildContext context,
    TextEditingController otpController,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    GlobalKey<FormState> formKey,
  ) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Full name field
            CustomTxtFormField(
              hintText: 'Enter the 6-Digit OTP',
              controller: otpController,
              validator: (val) {
                if (val!.length < 6) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            kHeight(20),

            // Email address field
            CustomTxtFormField(
              hintText: 'New Password',
              controller: passwordController,
              validator: (val) {
                if (!RegExp(passowrdRegexPattern).hasMatch(val!) ||
                    val.isEmpty) {
                  return 'Passwords should be 8 characters, at least one number and one special character';
                }
                return null;
              },
            ),
            kHeight(20),

            // Phone number field
            CustomTxtFormField(
              hintText: 'Confirm Password',
              controller: confirmPasswordController,
              validator: (val) {
                if (!RegExp(passowrdRegexPattern).hasMatch(val!) ||
                    val.isEmpty) {
                  return 'Passwords should be 8 characters, at least one number and one special character';
                }
                return null;
              },
            ),
            kHeight(20),

            // Confirm button
            BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
              listener: resetPasswordListener,
              child: CustomButton(
                buttonText: 'Save Changes',
                onPressed: () {
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    if (formKey.currentState!.validate()) {
                      context.read<ForgetPasswordBloc>().add(
                            ForgetResetPasswordEvent(
                              email: widget.emailController.text,
                              otp: otpController.text,
                              password: passwordController.text,
                            ),
                          );
                    }
                  } else {
                    customSnackbar(context, "Passwords doesn't match");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resetPasswordListener(BuildContext context, ForgetPasswordState state) {
    if (state is ForgetResetPasswordSuccessState) {
      nextScreenRemoveUntil(context, const UserSignInPage());
      customSnackbar(context, 'Password changed successfully');
    }
    if (state is ForgetResetPasswordInvalidOtpState) {
      customSnackbar(context, 'Entered OTP is invalid');
    }
  }
}
