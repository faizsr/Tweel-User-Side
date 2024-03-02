import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/validations.dart';
import 'package:tweel_social_media/presentation/cubit/drop_down_cubit.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/user_signup_two.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/account_type_dropdown.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

class SignUpOneFieldWidget extends StatefulWidget {
  const SignUpOneFieldWidget({super.key});

  @override
  State<SignUpOneFieldWidget> createState() => _SignUpOneFieldWidgetState();
}

class _SignUpOneFieldWidgetState extends State<SignUpOneFieldWidget> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create an account',
                  style:
                      TextStyle(fontSize: 20, fontVariations: fontWeightW700),
                ),
                kHeight(10),
                const Text(
                  "Please enter you information and create your account.",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            kHeight(25),
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
                      nextScreen(
                        context,
                        UserSignUpPageTwo(
                          email: emailController.text,
                          accountType: state.name,
                          fullName: fullnameController.text,
                          phoneNo: phoneNumberController.text,
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
