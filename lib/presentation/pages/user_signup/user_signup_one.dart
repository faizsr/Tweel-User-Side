import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/constants.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class UserSignUpPageOne extends StatelessWidget {
  const UserSignUpPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                signUpForm(context),
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

  Widget signUpForm(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Full name field
            const CustomTxtFormField(
              hintText: 'Full name',
            ),
            kHeight(20),

            // Email address field
            const CustomTxtFormField(
              hintText: 'Email address',
            ),
            kHeight(20),

            // Phone number field
            const CustomTxtFormField(
              hintText: 'Phone number',
            ),
            kHeight(20),

            // Account type field
            const CustomTxtFormField(
              hintText: 'Account type',
            ),
            kHeight(25),

            // Continue button
            CustomButton(
              buttonText: 'Continue',
              onPressed: () {
                SignUpWidgets.validateEmail(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
