import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
import 'package:tweel_social_media/presentation/widgets/shimmer_animate.dart';

class CreatePostCardLoading extends StatelessWidget {
  const CreatePostCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: kBoxShadow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ShimmerAnimate(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                ),
                kWidth(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Skelton(width: 160),
                    kHeight(10),
                    const Skelton(width: 60),
                  ],
                ),
                kHeight(25),
              ],
            ),
            kHeight(20),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'CREATE NEW POST',
                  style: TextStyle(
                    fontSize: 10,
                    fontVariations: fontWeightW800,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
