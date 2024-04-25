import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/widgets/shimmer_animate.dart';

class FadeInAnimate extends StatelessWidget {
  const FadeInAnimate({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 250),
      duration: const Duration(milliseconds: 250),
      child: child,
    );
  }
}

class FadedImageLoading extends StatelessWidget {
  const FadedImageLoading({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return FadeInAnimate(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return ShimmerAnimate(
            child: Container(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          );
        },
      ),
    );
  }
}
