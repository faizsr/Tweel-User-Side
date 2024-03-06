import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';

class CustomAppbar {
  static AppBar show(BuildContext context, enableIcon) {
    return AppBar(
      backgroundColor: kWhite,
      elevation: 0,
      centerTitle: true,
      leading: enableIcon
          ? FadeInLeft(
              delay: const Duration(milliseconds: 700),
              duration: const Duration(milliseconds: 1000),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(CustomIcons.arrow_left),
              ),
            )
          : const SizedBox(),
      title: FadeInDown(
        delay: const Duration(milliseconds: 700),
        duration: const Duration(milliseconds: 1000),
        child: const Text(
          'Tweel.',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
