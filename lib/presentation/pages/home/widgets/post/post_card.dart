import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_action_btns.dart';
import 'package:tweel_social_media/presentation/widgets/post_image_widget.dart';
import 'package:tweel_social_media/presentation/widgets/post_user_widget.dart';
import 'package:tweel_social_media/presentation/widgets/read_more_widget.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  final PostModel postModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: kBoxShadow,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Posted User Details
          PostUserDetail(
            postModel: postModel,
            userModel: userModel,
          ),
          kHeight(15),

          // Post Description
          ReadMoreWidget(
            text: postModel.description,
            postModel: postModel,
            userModel: userModel,
          ),
          kHeight(15),

          // Post Image Section
          PostImageWidget(postModel: postModel, height: 380),
          kHeight(15),

          // Post Action Buttons
          PostActionButtons(postModel: postModel, userModel: userModel)
        ],
      ),
    );
  }
}
