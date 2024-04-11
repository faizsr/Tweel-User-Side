import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class EmptyPostWidget extends StatelessWidget {
  const EmptyPostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: kBoxShadow,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Column(
          children: [
            kHeight(80),
            const Text(
              "No one posted yet!",
              style: TextStyle(
                fontSize: 18,
                fontVariations: fontWeightW600,
              ),
            ),
            kHeight(5),
            Text(
              'Be the first one to post \nin Tweel.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            kHeight(80),
          ],
        ),
      ).animate().shimmer(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            delay: 400.ms,
            duration: 1400.ms,
          ),
    );
  }
}
