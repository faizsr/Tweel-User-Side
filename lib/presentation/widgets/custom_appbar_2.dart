import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';

class CustomAppbar2 extends StatelessWidget {
  const CustomAppbar2({
    super.key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
  });

  final String title;
  final void Function()? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(Ktweel.arrow_left, size: 24),
      ),
      titleSpacing: 0,
    );
  }
}
