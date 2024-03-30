import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';

class ProfilePageLoading extends StatelessWidget {
  const ProfilePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    mySystemTheme(context);
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Skelton(
                    width: 70,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Ktweel.settings,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ],
              ),
              kHeight(10),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 40,
                          color: Colors.black.withOpacity(0.05),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor:
                                    Theme.of(context).colorScheme.onSurface,
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outlineVariant,
                                      ),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'EDIT PROFILE',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontVariations: fontWeightW800,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outlineVariant,
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
                  Positioned(
                    bottom: -40,
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        border: Border.all(
                          width: 0.5,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 40,
                            color: Colors.black.withOpacity(0.05),
                          )
                        ],
                      ),
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
                            color: Theme.of(context).colorScheme.outlineVariant,
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
                            color: Theme.of(context).colorScheme.outlineVariant,
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
                ],
              )
            ],
          ),
        ),
        kHeight(50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            )
          ],
        ),
        kHeight(20),
        StaggeredGridView.countBuilder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(color: Theme.of(context).colorScheme.primaryContainer);
          },
          staggeredTileBuilder: (index) => StaggeredTile.count(
              (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ],
    );
  }
}
