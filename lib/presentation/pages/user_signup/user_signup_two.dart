import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/constants.dart';
import 'package:tweel_social_media/presentation/pages/home/home_page.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class UserSignUpPageTwo extends StatelessWidget {
  const UserSignUpPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
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
                signUpForm(formKey, context),
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

  Widget signUpForm(GlobalKey<FormState> formKey, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTxtFormField(
              hintText: 'Username',
            ),
            kHeight(20),
            const CustomTxtFormField(
              hintText: 'Create password',
            ),
            kHeight(20),
            const CustomTxtFormField(
              hintText: 'Confirm password',
            ),
            kHeight(25),
            CustomButton(
              buttonText: 'Sign Up',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
