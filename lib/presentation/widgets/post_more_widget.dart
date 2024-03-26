import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/bloc_logics/post_logics_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/edit_post/edit_post.dart';

class PostMoreWidget {
  static Future<dynamic> bottomSheet({
    required BuildContext context,
    PostModel? postModel,
    required String userId,
    String? postId,
  }) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
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
        Set<String> savedPostIds = context.read<PostLogicsBloc>().savedPostIds;
        return FadeInUp(
          delay: const Duration(milliseconds: 100),
          duration: const Duration(milliseconds: 600),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  BlocConsumer<PostLogicsBloc, PostLogicsState>(
                    listener: (context, state) {
                      if (state is SavedPostSuccessState) {
                        changeSystemThemeOnPopup(
                            color: isDarkMode ? dBottom : lBottom);
                        context
                            .read<SavedPostsBloc>()
                            .add(FetchAllSavedPostEvent());
                      }
                      if (state is UnsavePostSuccessState) {
                        changeSystemThemeOnPopup(
                            color: isDarkMode ? dBottom : lBottom);
                        context
                            .read<SavedPostsBloc>()
                            .add(FetchAllSavedPostEvent());
                      }
                    },
                    builder: (context, state) {
                      return ListTile(
                        leading: savedPostIds.contains(postModel!.id)
                            ? const Icon(Icons.bookmark)
                            : const Icon(Icons.bookmark_border_outlined),
                        onTap: () {
                          if (savedPostIds.contains(postModel.id)) {
                            // isSaved = false;
                            context
                                .read<PostLogicsBloc>()
                                .add(UnsavePostEvent(postId: postModel.id!));
                          } else {
                            // isSaved = true;
                            context
                                .read<PostLogicsBloc>()
                                .add(SavePostEvent(postId: postModel.id!));
                          }
                        },
                        title:
                            savedPostIds.contains(postModel.id) ? const Text('Unsave') : const Text('Save'),
                      );
                    },
                  ),
                  (postModel!.user!.id ?? postId) == userId
                      ? Column(
                          children: [
                            BlocListener<PostLogicsBloc, PostLogicsState>(
                              listener: (context, state) {
                                if (state is EditPostSuccessState) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  context
                                      .read<PostBloc>()
                                      .add(PostInitialFetchEvent());
                                  context
                                      .read<ProfileBloc>()
                                      .add(UserDetailInitialFetchEvent());
                                }
                              },
                              child: ListTile(
                                leading: const Icon(Icons.edit),
                                title: const Text('Edit post'),
                                onTap: () {
                                  nextScreen(
                                    context,
                                    EditPostPage(
                                      description: postModel.description,
                                      location: postModel.location,
                                      imageUrlList: postModel.mediaURL!,
                                      postId: postModel.id!,
                                    ),
                                  );
                                },
                              ),
                            ),
                            BlocListener<PostLogicsBloc, PostLogicsState>(
                              listener: (context, state) {
                                if (state is RemovePostSuccessState) {
                                  Navigator.pop(context);
                                  context
                                      .read<PostBloc>()
                                      .add(PostInitialFetchEvent());
                                  context
                                      .read<ProfileBloc>()
                                      .add(UserDetailInitialFetchEvent());
                                }
                              },
                              child: ListTile(
                                leading: const Icon(Icons.delete),
                                title: const Text('Remove post'),
                                onTap: () {
                                  context.read<PostLogicsBloc>().add(
                                      RemovePostEvent(postId: postModel.id!));
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  (postModel.user!.id ?? postId) != userId
                      ? const Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.report_sharp),
                              title: Text('Report'),
                            ),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text('View account'),
                            )
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    ).then((value) {
      mySystemTheme(context);
    });
  }
}
