// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool('SIGNIN', false);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const UserSignInPage(),
          ));
        },
        child: const Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 30),
          ),
        )
        ,
      ),
    );
  }
}
