import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/pages/forgot_password/widgets/forget_form_widget.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar.show(context,true),
      body: const ForgetFieldWidget(),
    );
  }
}
