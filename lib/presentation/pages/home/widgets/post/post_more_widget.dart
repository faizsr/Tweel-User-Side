import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_more_bottom_sheet.dart';

class PostMoreWidget {
  static Future<dynamic> bottomSheet({
    required BuildContext context,
    PostModel? postModel,
    required String userId,
    String? postId,
    bool? onDetail,
  }) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      useRootNavigator: true,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - 40,
      ),
      builder: (context) {
        return BlocBuilder<SavedPostsBloc, SavedPostsState>(
          builder: (context, state) {
            if (state is FetchAllSavedPostSuccessState) {
              List<PostModel> savedPostList = state.savedPosts;
              return PostMoreBottomSheet(
                postModel: postModel!,
                userId: userId,
                onDetail: onDetail!,
                postId: postId!,
                savedPostList: savedPostList,
              );
            }
            List<PostModel> savedPostList = [];
            return PostMoreBottomSheet(
              postModel: postModel!,
              userId: userId,
              onDetail: onDetail!,
              postId: postId!,
              savedPostList: savedPostList,
            );
          },
        );
      },
    ).then((value) {
      mySystemTheme(context);
    });
  }
}
