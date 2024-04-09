import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
import 'package:tweel_social_media/presentation/widgets/shimmer_animate.dart';

class NotificationLoadingWidget extends StatelessWidget {
  const NotificationLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(15),
      children: [
        _likeLoadingCard(theme),
        kHeight(20),
        _commentLoadingCard(theme),
        kHeight(20),
        _followLoadingCard(theme),
        kHeight(20),
        _likeLoadingCard(theme),
      ],
    );
  }

  Container _followLoadingCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ShimmerAnimate(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: theme.colorScheme.onSurface,
                ),
                kWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Skelton(width: 170),
                    kHeight(10),
                    Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: theme.colorScheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: Text(
                          'FOLLOW BACK',
                          style: TextStyle(
                            fontSize: 10,
                            fontVariations: fontWeightW800,
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Skelton(
              width: 60,
            ),
          )
        ],
      ),
    );
  }

  Container _commentLoadingCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ShimmerAnimate(
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(2)),
                ),
                kWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Skelton(width: 170),
                    kHeight(10),
                    const Skelton(width: 120),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Skelton(
              width: 60,
            ),
          )
        ],
      ),
    );
  }

  Container _likeLoadingCard(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          ShimmerAnimate(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: theme.colorScheme.onSurface,
                ),
                kWidth(10),
                const Skelton(width: 170),
                const Spacer(),
              ],
            ),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Skelton(width: 60),
          )
        ],
      ),
    );
  }
}
