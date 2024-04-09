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
    var theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: color ?? theme.colorScheme.secondary),
            kWidth(5),
            Text(
              title,
              style:
                  TextStyle(fontSize: 13, color: theme.colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
