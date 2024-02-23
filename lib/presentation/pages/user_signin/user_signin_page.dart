import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_in/sign_in_bloc.dart';
import 'package:tweel_social_media/presentation/pages/forgot_password/forget_password_page.dart';
import 'package:tweel_social_media/presentation/pages/home/home_page.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class UserSignInPage extends StatefulWidget {
  const UserSignInPage({super.key});

  @override
  State<UserSignInPage> createState() => _UserSignInPageState();
}

class _UserSignInPageState extends State<UserSignInPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
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
      body:
          signInForm(formKey, context, usernameController, passwordController),
    );
  }

  Widget signInForm(
    GlobalKey<FormState> formKey,
    BuildContext context,
    TextEditingController usernameControllerr,
    TextEditingController passwordController,
  ) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: signInListener,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 30),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                kHeight(30),
                const Spacer(),

                // Username field
                CustomTxtFormField(
                  controller: usernameController,
                  hintText: 'Username',
                  validator: (value) {
                    if (value!.length < 4) {
                      return 'Username should not be empty';
                    }
                    if (state is InvalidUsernameErrorState) {
                      return "Username doesn't exists";
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
                    if ((state is InvalidPasswordErrorState)) {
                      return "Incorrect password";
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
                const Spacer(),
                SignInWidgets.signUpNavigate(context),
              ],
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
    if (state is UserSignInSuccessState) {
      nextScreenRemoveUntil(context, const HomePage());
    }
    if (state is UserSignInErrorState) {
      customSnackbar(context, 'Error signing in');
    }
  }
}
