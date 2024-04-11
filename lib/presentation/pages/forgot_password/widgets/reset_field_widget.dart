import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/core/utils/validations.dart';
import 'package:tweel_social_media/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class ResetFieldWidget extends StatefulWidget {
  const ResetFieldWidget({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<ResetFieldWidget> createState() => _ResetFieldWidgetState();
}

class _ResetFieldWidgetState extends State<ResetFieldWidget> {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 1000),
      child: Form(
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
                                email: widget.email,
                                otp: otpController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    } else {
                      customSnackbar(context, "Passwords doesn't match",
                          leading: Ktweel.shield_cross, trailing: 'OK');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPasswordListener(BuildContext context, ForgetPasswordState state) {
    if (state is ForgetResetPasswordSuccessState) {
      nextScreenRemoveUntil(context, const UserSignInPage());
      customSnackbar(context, 'Password changed successfully',
          leading: Ktweel.shield_tick, trailing: 'OK');
    }
    if (state is ForgetResetPasswordInvalidOtpState) {
      customSnackbar(context, 'Entered OTP is invalid',
          leading: Ktweel.info_circle, trailing: 'OK');
    }
  }
}
