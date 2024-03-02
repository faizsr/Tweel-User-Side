import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/widgets/signin_field_widget.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar.dart';

class UserSignInPage extends StatefulWidget {
  const UserSignInPage({super.key});

  @override
  State<UserSignInPage> createState() => _UserSignInPageState();
}

class _UserSignInPageState extends State<UserSignInPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar.show(),
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 30),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const SignInFieldWidget(),
                Positioned(
                  bottom: 0,
                  child: SignInWidgets.signUpNavigate(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
