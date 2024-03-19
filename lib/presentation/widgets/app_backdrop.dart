import 'dart:ui';

import 'package:flutter/material.dart';

class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    super.key,
    this.strength = 1,
  });

  final double strength;

  @override
  Widget build(BuildContext context) {
    final double normalStrength = clampDouble(strength, 0, 0.1);
    return BackdropFilter(
      filter: ImageFilter.blur(
          sigmaX: normalStrength * 15, sigmaY: normalStrength * 15),
      child: const SizedBox.expand(),
    );
  }
}
