import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/constants.dart';
import 'package:tweel_social_media/core/validations.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class UserSignUpPageTwo extends StatefulWidget {
  const UserSignUpPageTwo({
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
  State<UserSignUpPageTwo> createState() => _UserSignUpPageTwoState();
}

class _UserSignUpPageTwoState extends State<UserSignUpPageTwo> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();

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
                  context: context,
                  accountType: widget.accountType,
                  email: widget.email,
                  formKey: formKey,
                  fullName: widget.fullName,
                  otpController: otpController,
                  phoneNumber: widget.phoneNo,
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

  Widget signUpForm({
    required BuildContext context,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String accountType,
    required TextEditingController otpController,
    required GlobalKey<FormState> formKey,
  }) {
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
            signUpVerifyEmailBtn(fullName, email, phoneNumber, accountType,
                otpController, formKey, context),
          ],
        ),
      ),
    );
  }

// Sign Up Button
  Widget signUpVerifyEmailBtn(
      String fullName,
      String email,
      String phoneNumber,
      String accountType,
      TextEditingController otpController,
      GlobalKey<FormState> formKey,
      BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
   
        if (state is UserOtpSuccessState) {
          SignUpWidgets.validateEmail(
            context: context,
            fullName: fullName,
            email: email,
            phoneNo: phoneNumber,
            accountType: accountType,
            otpController: otpController,
            username: userNameController.text,
            password: passWordController.text,
          );
        }
      },
      child: CustomButton(
        buttonText: 'Sign Up',
        onPressed: () {
          if (passWordController.text == confirmPasswordController.text) {
            if (formKey.currentState!.validate()) {
              context
                  .read<SignUpBloc>()
                  .add(UserOtpVerificationEvent(email: email));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Passwords doesn't match"),
            ));
          }
        },
      ),
    );
  }
}
