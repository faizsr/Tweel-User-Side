import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CustomAppbar {
  static AppBar show() {
    return AppBar(
      backgroundColor: kWhite,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Tweel.',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}
