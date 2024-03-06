import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_in/sign_in_bloc.dart';
import 'package:tweel_social_media/presentation/pages/forgot_password/forget_password_page.dart';
import 'package:tweel_social_media/presentation/pages/main/main_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class SignInFieldWidget extends StatefulWidget {
  const SignInFieldWidget({super.key});

  @override
  State<SignInFieldWidget> createState() => _SignInFieldWidgetState();
}

class _SignInFieldWidgetState extends State<SignInFieldWidget> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: signInListener,
      builder: (context, state) {
        return FadeInDown(
          delay: const Duration(milliseconds: 700),
          duration: const Duration(milliseconds: 1000),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 30),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back!',
                          style: TextStyle(
                              fontSize: 20, fontVariations: fontWeightW700),
                        ),
                        kHeight(10),
                        const Text(
                          "Enter your login details to continue.",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  kHeight(25),
                  // Username field
                  CustomTxtFormField(
                    controller: usernameController,
                    hintText: 'Username',
                    validator: (value) {
                      if (value!.length < 4) {
                        return 'Username should not be empty';
                      }
                      return null;
                    },
                  ),
                  kHeight(20),

                  // Password field
                  CustomTxtFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    validator: (value) {
                      if (value!.length < 4) {
                        return 'Password should not be empty';
                      }
                      return null;
                    },
                  ),
                  kHeight(25),

                  // Sign in button
                  CustomButton(
                    buttonText: 'Sign In',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<SignInBloc>().add(
                              UserSignInEvent(
                                username: usernameController.text,
                                password: passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                  kHeight(10),
                  InkWell(
                    onTap: () {
                      nextScreen(context, const ForgotPasswordPage());
                    },
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Forget Password?',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void signInListener(BuildContext context, SignInState state) {
    if (state is InvalidUsernameErrorState) {
      customSnackbar(context, "Username doesn't exist");
    }
    if (state is InvalidPasswordErrorState) {
      customSnackbar(context, "Incorrect password");
    }
    if (state is BlockedbyAdminErrorState) {
      customSnackbar(context, 'You have by blocked by tweel');
    }
    if (state is UserSignInSuccessState) {
      nextScreenRemoveUntil(context, MainPage());
    }
    if (state is UserSignInErrorState) {
      customSnackbar(context, 'Error signing in');
    }
  }
}