import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/comment/comment_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/like_unlike_post/like_unlike_post_bloc.dart';
import 'package:tweel_social_media/presentation/widgets/custom_icon_btn.dart';

class DetailPostActionBtns extends StatelessWidget {
  const DetailPostActionBtns({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  final PostModel postModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            likePostButton(),
            Container(
              color: theme.colorScheme.outlineVariant,
              height: 15,
              width: 1,
            ),
            BlocBuilder<CommentBloc, CommentState>(
              builder: (context, state) {
                return CustomIconBtn(
                  title: '${postModel.comments!.length} comments',
                  icon: Ktweel.comment,
                  onTap: () {},
                );
              },
            ),
            Container(
              color: theme.colorScheme.outlineVariant,
              height: 15,
              width: 1,
            ),
            CustomIconBtn(
              title: 'Share',
              icon: Ktweel.send_2,
              onTap: () {},
            ),
          ],
        ),
        Divider(
          height: 0,
          thickness: 0.5,
          color: theme.colorScheme.outlineVariant,
        ),
      ],
    );
  }

  BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState> likePostButton() {
    return BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState>(
      builder: (context, state) {
        return CustomIconBtn(
          title: '${postModel.likes!.length} likes',
          color: postModel.likes!.contains(userModel.id)
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.secondary,
          icon: postModel.likes!.contains(userModel.id)
              ? Ktweel.like
              : Ktweel.like,
          onTap: () {
            if (postModel.likes!.contains(userModel.id)) {
              postModel.likes!.remove(userModel.id.toString());
              context.read<LikeUnlikePostBloc>().add(
                    UnlikePostEvent(postId: postModel.id!),
                  );
              debugPrint('unliking post');
            } else {
              postModel.likes!.add(userModel.id.toString());
              context.read<LikeUnlikePostBloc>().add(
                    LikePostEvent(postId: postModel.id!),
                  );
              debugPrint('liking post');
            }
          },
        );
      },
    );
  }
}
