import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CustomTextBtn extends StatelessWidget {
  const CustomTextBtn({
    super.key,
    required this.onTap,
    required this.bntText,
  });

  final void Function()? onTap;
  final String bntText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          bntText,
          style: TextStyle(
            fontVariations: fontWeightW500,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
