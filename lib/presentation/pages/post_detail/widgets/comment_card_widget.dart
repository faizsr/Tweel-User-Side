import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/comment/comment_bloc.dart';

class CommentCardWidget extends StatelessWidget {
  const CommentCardWidget({
    super.key,
    required this.commentModel,
    required this.postModel,
  });

  final CommentModel commentModel;
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<CommentBloc>().add(DeleteCommentEvent(
                  postId: postModel.id!,
                  commentId: commentModel.id,
                  postModel: postModel,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(commentModel.user.profilePicture!),
                ),
                kWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      commentModel.user.fullName!,
                      style: const TextStyle(fontSize: 15),
                    ),
                    kHeight(5),
                    Text(
                      commentModel.comment,
                      style: const TextStyle(
                        color: kDarkGrey,
                        fontSize: 13,
                      ),
                    ),
                    kHeight(10),
                    Row(
                      children: [
                        const Icon(CustomIcons.like, size: 18),
                        kWidth(5),
                        const Text('like'),
                      ],
                    ),
                    // kHeight(20),
                  ],
                ),
                const Spacer(),
                Text(
                  timeAgo(DateTime.parse(commentModel.createdDate)),
                  style: const TextStyle(color: kGray, fontSize: 11),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
