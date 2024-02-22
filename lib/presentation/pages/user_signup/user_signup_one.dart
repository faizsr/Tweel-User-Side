import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/constants.dart';
import 'package:tweel_social_media/core/validations.dart';
import 'package:tweel_social_media/presentation/cubit/drop_down_cubit.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/user_signup_two.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/account_type_dropdown.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class UserSignUpPageOne extends StatefulWidget {
  const UserSignUpPageOne({super.key});

  @override
  State<UserSignUpPageOne> createState() => _UserSignUpPageOneState();
}

class _UserSignUpPageOneState extends State<UserSignUpPageOne> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
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
                  fullnameController,
                  emailController,
                  phoneNumberController,
                  accountTypeController,
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
    TextEditingController fullnameController,
    TextEditingController emailController,
    TextEditingController phoneNumberController,
    TextEditingController accountTypeController,
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
              hintText: 'Full name',
              controller: fullnameController,
              validator: (val) {
                if (val!.length < 3) {
                  return 'Email field cannot be empty';
                }
                return null;
              },
            ),
            kHeight(20),

            // Email address field
            CustomTxtFormField(
              hintText: 'Email address',
              controller: emailController,
              validator: (val) {
                if (!RegExp(emailRegexPattern).hasMatch(val!) || val.isEmpty) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            kHeight(20),

            // Phone number field
            CustomTxtFormField(
              hintText: 'Phone number',
              controller: phoneNumberController,
              validator: (val) {
                if (val!.length < 10) {
                  return 'Enter a valid phone number';
                }
                return null;
              },
            ),
            kHeight(20),

            // Account type field
            const AccountTypeDropDown(),
            kHeight(25),

            // Continue button
            BlocBuilder<DropdownCubit, DropdownState>(
              builder: (context, state) {
                return CustomButton(
                  buttonText: 'Continue',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UserSignUpPageTwo(
                            email: emailController.text,
                            accountType: state.name,
                            fullName: fullnameController.text,
                            phoneNo: phoneNumberController.text,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
