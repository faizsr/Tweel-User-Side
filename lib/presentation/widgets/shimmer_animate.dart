import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ShimmerAnimate extends StatelessWidget {
  const ShimmerAnimate({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child
        .animate(
          onPlay: (controller) => controller.repeat(),
        )
        .shimmer(
          delay: 1000.ms,
          duration: 500.ms,
          color: Theme.of(context).colorScheme.scrim,
        );
  }
}
