import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/pages/forgot_password/widgets/reset_field_widget.dart';
import 'package:tweel_social_media/presentation/pages/user_signup/widgets/widgets.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;

    return Scaffold(
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
                ResetFieldWidget(email: widget.emailController.text),
                Positioned(
                  bottom: 0,
                  child: SignUpWidgets.signInNavigate(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
