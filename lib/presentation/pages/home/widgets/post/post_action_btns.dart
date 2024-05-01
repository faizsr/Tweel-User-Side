import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/comment/comment_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/like_unlike_post/like_unlike_post_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_icon_btn.dart';

class PostActionButtons extends StatefulWidget {
  const PostActionButtons({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  final PostModel postModel;
  final UserModel userModel;

  @override
  State<PostActionButtons> createState() => _PostActionButtonsState();
}

class _PostActionButtonsState extends State<PostActionButtons> {
  late FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

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
            fToast.showToast(
              child: customToast(context),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 2),
            );
          },
        ),
      ],
    );
  }

  Widget commentButton(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return CustomIconBtn(
          title: '${widget.postModel.comments!.length} comments',
          icon: Ktweel.comment,
          onTap: () {
            debugPrint('Comment pressed');
            nextScreen(
              context,
              PostDetailPage(
                postModel: widget.postModel,
                userModel: widget.userModel,
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
          title: '${widget.postModel.likes!.length} likes',
          color: widget.postModel.likes!.contains(widget.userModel.id)
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.secondary,
          icon: widget.postModel.likes!.contains(widget.userModel.id)
              ? Ktweel.like
              : Ktweel.like,
          onTap: () {
            if (widget.postModel.likes!.contains(widget.userModel.id)) {
              widget.postModel.likes!.remove(widget.userModel.id.toString());
              context.read<LikeUnlikePostBloc>().add(
                    UnlikePostEvent(postId: widget.postModel.id!),
                  );
              debugPrint('Unliking post');
            } else {
              widget.postModel.likes!.add(widget.userModel.id.toString());
              context.read<LikeUnlikePostBloc>().add(
                    LikePostEvent(postId: widget.postModel.id!),
                  );
              debugPrint('Liking post');
            }
          },
        );
      },
    );
  }
}
