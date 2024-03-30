import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';

class CustomAppbar2 extends StatelessWidget {
  const CustomAppbar2({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Ktweel.arrow_left, size: 24),
      ),
      titleSpacing: 0,
    );
  }
}
