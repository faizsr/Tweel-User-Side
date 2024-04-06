import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/widgets/comment_text_field.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/widgets/comments_area_widget.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/widgets/detail_post_action_btns.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar_2.dart';
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
    changeSystemThemeOnPopup(
      color: Theme.of(context).colorScheme.surface,
      context: context,
    );
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
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                children: [
                  // ============= Posted User Detial =============
                  PostUserDetail(
                    postModel: postModel,
                    userModel: userModel,
                    onDetail: true,
                  ),
                  kHeight(20),

                  // ============= Post Description =============
                  Text(
                    postModel.description,
                    textAlign: TextAlign.start,
                    style: const TextStyle(fontSize: 13),
                  ),
                  kHeight(10),

                  // ============= Post Image Widget =============
                  PostImageWidget(
                    postModel: postModel,
                    height: 420,
                    onDetail: true,
                  ),
                  kHeight(5),

                  // ============= Post Action Buttons =============
                  DetailPostActionBtns(
                    postModel: postModel,
                    userModel: userModel!,
                  ),

                  // ============= Comments View Section
                  CommentAreaWidget(postModel: postModel),
                ],
              ),
            ),
          ),

          // ============= Comment Input Field =============
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
}
