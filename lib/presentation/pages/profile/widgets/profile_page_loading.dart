import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
import 'package:tweel_social_media/presentation/widgets/shimmer_animate.dart';

class ProfilePageLoading extends StatelessWidget {
  const ProfilePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    mySystemTheme(context);
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        Column(
          children: [
            _headingLoading(theme),
            kHeight(10),
            _userDetailCardLoading(theme)
          ],
        ),
        kHeight(50),
        _tabbarLoading(theme),
        kHeight(20),
        _postLoadingGrid(theme),
      ],
    );
  }

  Widget _postLoadingGrid(ThemeData theme) {
    return ShimmerAnimate(
      child: StaggeredGridView.countBuilder(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(color: theme.colorScheme.onSurface);
        },
        staggeredTileBuilder: (index) => StaggeredTile.count(
            (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
    );
  }

  Row _tabbarLoading(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShimmerAnimate(
          child: Container(
            height: 35,
            width: 100,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border.all(
                color: theme.colorScheme.primaryContainer,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        Container(
          height: 35,
          width: 100,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            border: Border.all(
              color: theme.colorScheme.primaryContainer,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(3),
          ),
        )
      ],
    );
  }

  Widget _userDetailCardLoading(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 40,
                  color: Colors.black.withOpacity(0.05),
                )
              ],
            ),
            child: ShimmerAnimate(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: theme.colorScheme.onSurface,
                        ),
                        kWidth(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Skelton(width: 100),
                            kHeight(10),
                            const Skelton(width: 50),
                            kHeight(10),
                            Container(
                              height: 35,
                              width: 150,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  color: theme.colorScheme.outlineVariant,
                                ),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Center(
                                child: Text(
                                  'EDIT PROFILE',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontVariations: fontWeightW800,
                                    color: theme.colorScheme.outlineVariant,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    kHeight(15),
                    const Skelton(width: 200),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                border: Border.all(
                  width: 0.5,
                  color: theme.colorScheme.outlineVariant,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 40,
                    color: Colors.black.withOpacity(0.05),
                  )
                ],
              ),
              child: ShimmerAnimate(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Skelton(width: 25, height: 35),
                          kHeight(5),
                          const Skelton(width: 40),
                        ],
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: 0.5,
                      color: theme.colorScheme.outlineVariant,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Skelton(width: 25, height: 35),
                          kHeight(5),
                          const Skelton(width: 60),
                        ],
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: 0.5,
                      color: theme.colorScheme.outlineVariant,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Skelton(width: 25, height: 35),
                          kHeight(5),
                          const Skelton(width: 60),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headingLoading(ThemeData theme) {
    return ShimmerAnimate(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 15, 0),
        child: Row(
          children: [
            Skelton(
              width: 70,
              color: theme.colorScheme.onSurface,
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Icon(
                Ktweel.settings,
                color: theme.colorScheme.outlineVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
