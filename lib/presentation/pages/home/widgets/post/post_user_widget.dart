// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/post_edit/post_edit_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/home/functions/post_functions.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_more_widget.dart';
import 'package:tweel_social_media/presentation/widgets/fadein_animate.dart';
import 'package:tweel_social_media/presentation/widgets/profile_circle_widget.dart';

class PostUserDetail extends StatefulWidget {
  const PostUserDetail({
    super.key,
    required this.postModel,
    this.userModel,
    this.onDetail = false,
  });

  final PostModel postModel;
  final UserModel? userModel;
  final bool onDetail;

  @override
  State<PostUserDetail> createState() => _PostUserDetailState();
}

class _PostUserDetailState extends State<PostUserDetail> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        InkWell(
          onTap: PostFunctions.onProfileTap(
            context: context,
            userModel: widget.userModel!,
            onDetail: widget.onDetail,
          ),
          child: ProfileCircleWidget(
            radius: 40,
            imageWidget: widget.postModel.user!.profilePicture == "" ||
                    widget.userModel!.profilePicture == ""
                ? Image.asset(profilePlaceholder)
                : FadedImageLoading(
                    imageUrl: widget.postModel.user!.profilePicture ??
                        widget.userModel!.profilePicture!,
                  ),
          ),
        ),
        kWidth(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.postModel.user!.fullName ??
                      widget.userModel!.fullName!.capitalize(),
                  style: const TextStyle(fontSize: 15),
                ),
                kWidth(15),
                BlocBuilder<PostEditBloc, PostEditState>(
                  builder: (context, state) {
                    if (state is EditPostSuccessState) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Edited",
                          style: TextStyle(
                            fontSize: 11,
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                )
              ],
            ),
            kHeight(5),
            SizedBox(
              width: 150,
              child: Text(
                widget.postModel.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                filterPostTime(DateTime.parse(widget.postModel.createdDate ??
                    widget.userModel!.createdAt!)),
                style: TextStyle(
                  fontSize: 11,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileFetchingSucessState) {
                  return InkWell(
                    onTap: () {
                      changeSystemThemeOnPopup(
                        color: widget.onDetail
                            ? theme.colorScheme.background
                            : theme.colorScheme.onBackground,
                        context: context,
                      );
                      PostMoreWidget.bottomSheet(
                        context: context,
                        postModel: widget.postModel,
                        userId: state.userDetails.id!,
                        postId: widget.userModel!.id!,
                        onDetail: widget.onDetail,
                      );
                    },
                    child: const Icon(Ktweel.more_vert),
                  );
                }
                return const Icon(Ktweel.more_vert);
              },
            ),
          ],
        ),
      ],
    );
  }
}
