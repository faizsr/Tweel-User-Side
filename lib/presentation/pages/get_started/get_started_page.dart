// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('ON_INITIAL', true);
        nextScreen(context, const UserSignInPage());
      },
      child: Scaffold(
        body: Image.asset('assets/images/splash_page.png'),
      ),
    );
  }
}
