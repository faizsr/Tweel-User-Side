// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.profileImage,
    required this.ontap,
    required this.buttonLabel,
    required this.leading,
  });

  final String profileImage;
  final List<void Function()?> ontap;
  final List<String> buttonLabel;
  final List<IconData> leading;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: profileImage == ""
                    ? Image.asset(profilePlaceholder).image
                    : NetworkImage(profileImage),
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 200))
                  .scale(begin: const Offset(.8, .8), curve: Curves.easeOut),
              kHeight(20),
              _buildBottomBtns(context, isDarkMode),
              kHeight(50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBtns(BuildContext context, bool isDarkMode) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _MenuTextBtn(
          label: buttonLabel[index],
          onTap: ontap[index],
          icon: leading[index],
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(thickness: 1, height: 1, color: lWhite)
            .animate()
            .scale(
              duration: const Duration(milliseconds: 800),
              delay: const Duration(microseconds: 500),
              curve: Curves.easeOutBack,
            );
      },
      itemCount: buttonLabel.length,
    );
  }
}

class _MenuTextBtn extends StatelessWidget {
  const _MenuTextBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(icon, color: lWhite, size: 20),
            kWidth(10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                color: lWhite,
                fontVariations: fontWeightW500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
