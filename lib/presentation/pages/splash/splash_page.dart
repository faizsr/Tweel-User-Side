// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweel_social_media/presentation/pages/get_started/get_started_page.dart';
import 'package:tweel_social_media/presentation/pages/home/home_page.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Tweel.',
          style: TextStyle(fontSize: 35),
        ),
      ),
    );
  }

  Future<void> checkUserStatus() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final userOnInitial = preferences.getBool('ON_INITIAL');
    final userSignIn = preferences.getBool('SIGNIN');
    if (userOnInitial == false) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const GetStartedPage(),
      ));
    } else {
      if (userSignIn == false) {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const UserSignInPage(),
        ));
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
      }
    }
  }
}
