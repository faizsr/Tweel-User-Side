import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/like_unlike_post/like_unlike_post_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_icon_btn.dart';
import 'package:tweel_social_media/presentation/widgets/post_image_widget.dart';
import 'package:tweel_social_media/presentation/widgets/post_user_widget.dart';

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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            blurRadius: 40,
            color: Colors.black.withOpacity(0.05),
          )
        ],
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
          ReadMoreText(
            postModel.description,
            trimLines: 3,
            textAlign: TextAlign.start,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'more',
            trimExpandedText: ' less',
            style: const TextStyle(fontSize: 13),
            lessStyle: const TextStyle(fontSize: 13, color: kGray),
            moreStyle: const TextStyle(fontSize: 13, color: kGray),
          ),
          kHeight(15),

          // Post Image Section
          PostImageWidget(postModel: postModel),
          kHeight(15),

          // Post Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              likeButton(),
              Container(height: 15, width: 1, color: Colors.grey.shade300),
              commentButton(context),
              Container(height: 15, width: 1, color: Colors.grey.shade300),
              CustomIconBtn(
                title: 'Share',
                icon: CustomIcons.send_2,
                onTap: () {
                  debugPrint('share pressed');
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget commentButton(BuildContext context) {
    return CustomIconBtn(
      title: 'Comment',
      icon: CustomIcons.messages_2,
      onTap: () {
        debugPrint('comment pressed');
        nextScreen(
            context,
            PostDetailPage(
              postModel: postModel,
              userModel: userModel,
            ));
      },
    );
  }

  Widget likeButton() {
    return BlocBuilder<LikeUnlikePostBloc, LikeUnlikePostState>(
      builder: (context, state) {
        return CustomIconBtn(
          title: 'Like',
          color: postModel.likes!.contains(userModel.id) ? kDarkBlue : kBlack,
          icon: postModel.likes!.contains(userModel.id)
              ? CupertinoIcons.heart_fill
              : CustomIcons.like,
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
