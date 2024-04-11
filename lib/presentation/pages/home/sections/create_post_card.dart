import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/media_picker_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
import 'package:tweel_social_media/presentation/widgets/shimmer_animate.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CreatePostCard extends StatefulWidget {
  const CreatePostCard({
    super.key,
  });

  @override
  State<CreatePostCard> createState() => _CreatePostCardState();
}

class _CreatePostCardState extends State<CreatePostCard> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        boxShadow: kBoxShadow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileInitialState) {
                context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
                return _loadingWidget();
              }
              if (state is ProfileFetchingLoadingState) {
                return _loadingWidget();
              }
              if (state is ProfileFetchingSucessState) {
                return Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: theme.colorScheme.onSurface,
                          backgroundImage: state.userDetails.profilePicture ==
                                  ""
                              ? Image.asset(profilePlaceholder).image
                              : NetworkImage(state.userDetails.profilePicture!),
                        ),
                        kWidth(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Share you thoughts',
                              style: TextStyle(
                                fontSize: 16,
                                fontVariations: fontWeightW500,
                              ),
                            ),
                            kHeight(5),
                            Text(
                              '@${state.userDetails.username!.toLowerCase()}',
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    kHeight(25),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: CustomOutlinedBtn(
                        onPressed: () {
                          changeSystemThemeOnPopup(
                            color: theme.colorScheme.surface,
                            context: context,
                          );
                          nextScreen(
                            context,
                            const MediaPicker(
                              maxCount: 10,
                              requestType: RequestType.common,
                              screenType: ScreenType.post,
                            ),
                          ).then((value) => mySystemTheme(context));
                        },
                        btnText: 'CREATE NEW POST',
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _loadingWidget() {
    return ShimmerAnimate(
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
    );
  }
}
