import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/constants.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class UserSignInPage extends StatelessWidget {
  const UserSignInPage({super.key});

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
      body: signInForm(formKey, context),
    );
  }

  Widget signInForm(GlobalKey<FormState> formKey, BuildContext context) {
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
              hintText: 'Username',
              validator: (value) {
                if (value!.length < 4) {
                  return 'Username doesnot contain';
                }
                return null;
              },
            ),
            kHeight(20),

            // Password field
            CustomTxtFormField(
              hintText: 'Password',
              validator: (value) {
                if (value!.length < 4) {
                  return 'Username doesnot contain .,-';
                }
                return null;
              },
            ),
            kHeight(25),

            // Sign in button
            CustomButton(
              buttonText: 'Sign In',
              onPressed: () {},
            ),
            kHeight(10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forget Password?',
              ),
            ),
            const Spacer(),
            SignInWidgets.signUpNavigate(context),
          ],
        ),
      ),
    );
  }
}
