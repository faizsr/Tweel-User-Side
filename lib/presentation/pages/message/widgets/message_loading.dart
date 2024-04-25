import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
import 'package:tweel_social_media/presentation/widgets/shimmer_animate.dart';

class MessageLoading extends StatelessWidget {
  const MessageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
        itemCount: 5,
        itemBuilder: (context, index) {
          return ShimmerAnimate(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  kWidth(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Skelton(
                        width: MediaQuery.of(context).size.width - 250,
                      ),
                      kHeight(8),
                      Skelton(
                        width: MediaQuery.of(context).size.width - 300,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Skelton(
                    width: MediaQuery.of(context).size.width - 330,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
