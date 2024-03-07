import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class Skelton extends StatelessWidget {
  const Skelton({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: kLightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
