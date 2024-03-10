import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CustomIconBtn extends StatelessWidget {
  const CustomIconBtn({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
     this.color,
  });

  final String title;
  final IconData icon;
  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? Colors.black),
          kWidth(5),
          Text(title),
        ],
      ),
    );
  }
}
