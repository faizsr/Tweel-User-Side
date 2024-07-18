// ignore_for_file: use_build_context_synchronously

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_in/sign_in_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/toggle_password/toggle_password_cubit.dart';
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
          delay: const Duration(milliseconds: 400),
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
                  BlocBuilder<TogglePasswordCubit, bool>(
                    builder: (context, state) {
                      return CustomTxtFormField(
                        controller: passwordController,
                        hintText: 'Password',
                        suffix: GestureDetector(
                          onTap: () {
                            context.read<TogglePasswordCubit>().toggle();
                          },
                          child: Icon(
                            state ? Ktweel.eye_slash : Ktweel.eye,
                            size: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        obscureText: state,
                        validator: (value) {
                          if (value!.length < 4) {
                            return 'Password should not be empty';
                          }
                          return null;
                        },
                      );
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
      customSnackbar(context, "Username doesn't exist",
          leading: Ktweel.user_remove, trailing: 'OK');
    }
    if (state is InvalidPasswordErrorState) {
      customSnackbar(context, "Incorrect password",
          leading: Ktweel.shield_cross, trailing: 'OK');
    }
    if (state is BlockedbyAdminErrorState) {
      customSnackbar(context, 'You have by blocked by tweel',
          leading: Ktweel.info_rugged, trailing: 'OK');
    }
    if (state is UserSignInSuccessState) {
      context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
      context.read<UserBloc>().add(FetchAllUserEvent());
      context.read<PostBloc>().add(PostInitialFetchEvent());
      nextScreenRemoveUntil(context, const MainPage());
      mySystemTheme(context);
      context.read<TogglePasswordCubit>().reset();
    }
    if (state is UserSignInErrorState) {
      customSnackbar(context, 'Please try again after some times',
          leading: Ktweel.close_circle, trailing: 'OK');
    }
  }
}
