import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CustomIconBtn extends StatelessWidget {
  const CustomIconBtn({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20),
          kWidth(5),
          Text(title),
        ],
      ),
    );
  }
}
