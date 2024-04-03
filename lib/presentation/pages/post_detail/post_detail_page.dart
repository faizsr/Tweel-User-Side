import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/comment/comment_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/like_unlike_post/like_unlike_post_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/widgets/comment_card_widget.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/widgets/comment_text_field.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar_2.dart';
import 'package:tweel_social_media/presentation/widgets/custom_icon_btn.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_image_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_user_widget.dart';

class PostDetailPage extends StatelessWidget {
  PostDetailPage({
    super.key,
    required this.postModel,
    this.userModel,
  });

  final PostModel postModel;
  final UserModel? userModel;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppbar2(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: 'Post',
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostUserDetail(
                          postModel: postModel,
                          userModel: userModel,
                          onDetail: true,
                        ),
                        kHeight(20),
                        Text(
                          postModel.description,
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 13),
                        ),
                        kHeight(10),
                        PostImageWidget(
                          postModel: postModel,
                          height: 420,
                          onDetail: true,
                        ),
                        kHeight(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            likePostButton(),
                            Container(
                                color: Theme.of(context).colorScheme.outline,
                                height: 20,
                                width: 0.5),
                            BlocBuilder<CommentBloc, CommentState>(
                              builder: (context, state) {
                                return CustomIconBtn(
                                  title:
                                      '${postModel.comments!.length} comments',
                                  icon: Ktweel.comment,
                                  onTap: () {},
                                );
                              },
                            ),
                            Container(
                              color: Theme.of(context).colorScheme.outline,
                              height: 20,
                              width: 0.6,
                            ),
                            CustomIconBtn(
                              title: 'Share',
                              icon: Ktweel.send_2,
                              onTap: () {},
                            ),
                          ],
                        ),
                        Divider(
                          height: 30,
                          thickness: 0.3,
                          color: Theme.of(context).colorScheme.outline,
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<CommentBloc, CommentState>(
                    builder: (context, state) {
                      return Column(
                        children: List.generate(
                          postModel.comments!.length,
                          (index) => CommentCardWidget(
                            commentModel: postModel.comments![index],
                            postModel: postModel,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          CommentTextFieldWidget(
            postModel: postModel,
            onChanged: (p0) {
              scrollController.jumpTo(
                scrollController.position.maxScrollExtent,
              );
            },
            onTap: () {
              scrollController.jumpTo(
                scrollController.position.maxScrollExtent,
              );
            },
          ),
        ],
      ),
    );
  }

  BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState> likePostButton() {
    return BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState>(
      builder: (context, state) {
        return CustomIconBtn(
          title: '${postModel.likes!.length} likes',
          icon: postModel.likes!.contains(userModel!.id)
              ? Ktweel.dislike
              : Ktweel.like,
          onTap: () {
            if (postModel.likes!.contains(userModel!.id)) {
              postModel.likes!.remove(userModel!.id.toString());
              context.read<LikeUnlikePostBloc>().add(
                    UnlikePostEvent(postId: postModel.id!),
                  );
              debugPrint('unliking post');
            } else {
              postModel.likes!.add(userModel!.id.toString());
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
