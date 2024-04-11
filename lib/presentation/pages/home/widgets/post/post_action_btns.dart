import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/comment/comment_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/like_unlike_post/like_unlike_post_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_icon_btn.dart';

class PostActionButtons extends StatelessWidget {
  const PostActionButtons({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  final PostModel postModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        likeButton(theme),
        Container(
          height: 15,
          width: 1,
          color: theme.colorScheme.outlineVariant,
        ),
        commentButton(context),
        Container(
          height: 15,
          width: 1,
          color: theme.colorScheme.outlineVariant,
        ),
        CustomIconBtn(
          title: 'Share',
          icon: Ktweel.send_2,
          onTap: () {
            debugPrint('Share pressed');
          },
        ),
      ],
    );
  }

  Widget commentButton(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return CustomIconBtn(
          title: '${postModel.comments!.length} comments',
          icon: Ktweel.comment,
          onTap: () {
            debugPrint('Comment pressed');
            nextScreen(
              context,
              PostDetailPage(
                postModel: postModel,
                userModel: userModel,
              ),
            ).then((value) => mySystemTheme(context));
          },
        );
      },
    );
  }

  Widget likeButton(ThemeData theme) {
    return BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState>(
      builder: (context, state) {
        return CustomIconBtn(
          title: '${postModel.likes!.length} likes',
          color: postModel.likes!.contains(userModel.id)
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.secondary,
          icon: postModel.likes!.contains(userModel.id)
              ? Ktweel.like
              : Ktweel.like,
          onTap: () {
            if (postModel.likes!.contains(userModel.id)) {
              postModel.likes!.remove(userModel.id.toString());
              context.read<LikeUnlikePostBloc>().add(
                    UnlikePostEvent(postId: postModel.id!),
                  );
              debugPrint('Unliking post');
            } else {
              postModel.likes!.add(userModel.id.toString());
              context.read<LikeUnlikePostBloc>().add(
                    LikePostEvent(postId: postModel.id!),
                  );
              debugPrint('Liking post');
            }
          },
        );
      },
    );
  }
}
