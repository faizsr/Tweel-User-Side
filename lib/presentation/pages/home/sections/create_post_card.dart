import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/media_picker_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
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
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: kBoxShadow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is UserProfileInitialState) {
                context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
                return _loadingWidget();
              }
              if (state is UserDetailFetchingLoadingState) {
                return _loadingWidget();
              }
              if (state is UserDetailFetchingSucessState) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: kWhite,
                      backgroundImage: NetworkImage(
                        state.userDetails.profilePicture!,
                      ),
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
                          '@${state.userDetails.username}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                );
              }
              return Container();
            },
          ),
          kHeight(20),
          CustomOutlinedBtn(
            onPressed: () {
              nextScreen(
                context,
                const MediaPicker(
                  maxCount: 10,
                  requestType: RequestType.common,
                ),
              );
            },
            btnText: 'CREATE NEW POST',
          ),
        ],
      ),
    );
  }

  Widget _loadingWidget() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 28,
          backgroundColor: kLightGrey,
        ),
        kWidth(20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Skelton(width: 160),
            kHeight(10),
            const Skelton(width: 60),
          ],
        )
      ],
    );
  }
}
