import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/validations.dart';
import 'package:tweel_social_media/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:tweel_social_media/presentation/pages/forgot_password/reset_password_page.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kWhite,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Tweel.',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: signInForm(),
    );
  }

  Widget signInForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 30),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            kHeight(30),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Forgot your password?',
                  style:
                      TextStyle(fontSize: 20, fontVariations: fontWeightW700),
                ),
                kHeight(10),
                const Text(
                    "Enter the email address and we'll send you a OTP to reset your password"),
              ],
            ),
            kHeight(25),
            // Username field
            BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
              listener: forgetPasswordListener,
              child: CustomTxtFormField(
                controller: emailController,
                hintText: 'Email address',
                validator: (value) {
                  if (!RegExp(emailRegexPattern).hasMatch(value!) ||
                      value.isEmpty) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
              ),
            ),
            kHeight(25),

            // Sign in button
            CustomButton(
              buttonText: 'Send Reset Link',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context
                      .read<ForgetPasswordBloc>()
                      .add(ForgetSentOtpEvent(email: emailController.text));
                }
              },
            ),
            kHeight(10),
            const Spacer(),
            SignInWidgets.signUpNavigate(context),
          ],
        ),
      ),
    );
  }

  void forgetPasswordListener(BuildContext context, ForgetPasswordState state) {
    if (state is ForgetSentOtpSuccessState) {
      nextScreen(
        context,
        ResetPasswordPage(
          emailController: emailController,
        ),
      );
    }
    if (state is ForgetUserNotExistState) {
      customSnackbar(context, 'User not found with the email');
    }
  }
}
