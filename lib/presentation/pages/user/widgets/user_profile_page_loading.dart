import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';

class UserProfilePageLoading extends StatelessWidget {
  const UserProfilePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Ktweel.arrow_left_ios,
                        size: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  kWidth(10),
                  Skelton(width: 70, color: Theme.of(context).colorScheme.primaryContainer),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Ktweel.settings_2,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ],
              ),
            ),
            kHeight(10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Stack(
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
                                  Row(
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outlineVariant,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'FOLLOW',
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
                                      kWidth(10),
                                      Container(
                                        height: 35,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 0.5,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outlineVariant,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'MESSAGE',
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
                        border: Border.all(width: 0.5, color: kLightGrey2),
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
                            color: kLightGrey2,
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
                            color: kLightGrey2,
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
              ),
            )
          ],
        ),
        kHeight(50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  thickness: 0.5,
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
            const Text(
              'POSTS',
              style: TextStyle(
                  fontSize: 12,
                  fontVariations: fontWeightW500,
                  color: kLightGrey2),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(
                  thickness: 0.5,
                  color: Theme.of(context).colorScheme.outline,
                ),
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
          itemCount: 4,
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
