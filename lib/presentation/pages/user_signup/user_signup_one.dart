import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/signup_one_field_widget.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar.dart';

class UserSignUpPageOne extends StatefulWidget {
  const UserSignUpPageOne({super.key});

  @override
  State<UserSignUpPageOne> createState() => _UserSignUpPageOneState();
}

class _UserSignUpPageOneState extends State<UserSignUpPageOne> {
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        extendBodyBehindAppBar: true,
        appBar: CustomAppbar.show(context,true),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(minHeight: mediaHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SignUpOneFieldWidget(),
                  Positioned(
                    bottom: 0,
                    child: SignUpWidgets.signInNavigate(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
