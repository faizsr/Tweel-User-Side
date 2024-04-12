import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/loading_flw_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
import 'package:tweel_social_media/presentation/widgets/shimmer_animate.dart';

class ExplorePageLoading extends StatelessWidget {
  const ExplorePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              const Text('Suggested People'),
              const Spacer(),
              Text(
                'Show all',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
        StaggeredGridView.countBuilder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          shrinkWrap: true,
          crossAxisCount: 2,
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                boxShadow: kBoxShadow,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(radius: 30, backgroundColor: kLightGrey),
                  kHeight(15),
                  const Skelton(width: 100),
                  kHeight(10),
                  const Skelton(width: 70),
                  kHeight(15),
                  SizedBox(
                    height: 35,
                    width: double.infinity,
                    child: CustomOutlinedBtn(
                      onPressed: () {},
                      btnText: 'FOLLOW',
                    ),
                  )
                ],
              ),
            );
          },
        ),
        const Center(
          child: Text(
            'Explore',
            style: TextStyle(fontSize: 22),
          ),
        ),
        StaggeredGridView.countBuilder(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 30,
          itemBuilder: (context, index) {
            if (index % 2 == 0 || index == 29) {
              return const Tile(
                height: 220,
              );
            }
            if (index % 3 == 0) {
              return const Tile(height: 150);
            }
            return const Tile(height: 190);
          },
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ],
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.height,
  });

  final double height;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ShimmerAnimate(
      child: Container(
        height: height,
        color: theme.colorScheme.primaryContainer,
      ),
    );
  }
}

class SuggestedPeopleLoading extends StatelessWidget {
  const SuggestedPeopleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return StaggeredGridView.countBuilder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      shrinkWrap: true,
      crossAxisCount: 2,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            boxShadow: kBoxShadow,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: ShimmerAnimate(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.colorScheme.onSurface,
                ),
                kHeight(15),
                const Skelton(width: 100),
                kHeight(5),
                const Skelton(width: 70),
                kHeight(15),
                const LoadingFollowBtn(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ExplorePostLoading extends StatelessWidget {
  const ExplorePostLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 30,
      itemBuilder: (context, index) {
        if (index % 2 == 0 || index == 29) {
          return const Tile(
            height: 220,
          );
        }
        if (index % 3 == 0) {
          return const Tile(height: 150);
        }
        return const Tile(height: 190);
      },
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}
