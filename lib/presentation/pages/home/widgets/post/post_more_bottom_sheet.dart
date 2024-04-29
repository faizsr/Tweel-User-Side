// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/post_logics/post_logics_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/edit_post/edit_post.dart';
import 'package:tweel_social_media/presentation/pages/report/report_page.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';

class PostMoreBottomSheet extends StatefulWidget {
  const PostMoreBottomSheet({
    super.key,
    required this.postModel,
    required this.userId,
    required this.onDetail,
    required this.postId,
    required this.savedPostList,
  });

  final PostModel postModel;
  final String userId;
  final String postId;
  final bool onDetail;
  final List<PostModel> savedPostList;

  @override
  State<PostMoreBottomSheet> createState() => _PostMoreBottomSheetState();
}

class _PostMoreBottomSheetState extends State<PostMoreBottomSheet> {
  bool isSaved = false;

  @override
  void initState() {
    if (widget.savedPostList.isEmpty) {
      isSaved = false;
    }
    for (int i = 0; i < widget.savedPostList.length; i++) {
      if (widget.savedPostList[i].id == widget.postModel.id) {
        isSaved = true;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.all(20),
      curve: Curves.fastOutSlowIn,
      duration: const Duration(seconds: 1),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          saveUnsaveBtn(),

          // =========== If post is of current user ===========
          (widget.postModel.user!.id ?? widget.postId) == widget.userId
              ? Column(
                  children: [
                    editPostBtn(context),
                    removePostBtn(context),
                  ],
                )
              : const SizedBox(),

          // =========== else ===========
          (widget.postModel.user!.id ?? widget.postId) != widget.userId
              ? Column(
                  children: [reportPostBtn(), viewAccountBtn()],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  // =========== View Account Button ===========
  Widget viewAccountBtn() {
    return ListTile(
      leading: const Icon(Ktweel.user, size: 22),
      title: const Text('View account'),
      onTap: () {
        debugPrint('Go to profile');
        nextScreen(
            context,
            UserProfilePage(
              userId: widget.postModel.user!.id!,
              isCurrentUser: false,
            )).then(
          (value) {
            mySystemTheme(context);
            Navigator.pop(context);
          },
        );
        context
            .read<UserByIdBloc>()
            .add(FetchUserByIdEvent(userId: widget.postModel.user!.id!));
      },
    );
  }

// =========== Report Post Button ===========
  Widget reportPostBtn() {
    return ListTile(
      onTap: () {
        changeSystemThemeOnPopup(
          color: Theme.of(context).colorScheme.surface,
          context: context,
        );
        nextScreen(
          context,
          ReportPage(postId: widget.postModel.id!),
        ).then((value) {
          mySystemTheme(context);
          Navigator.pop(context);
        });
      },
      leading: const Icon(
        Ktweel.danger,
        size: 22,
      ),
      title: const Text('Report'),
    );
  }

// =========== Remove Post Button ===========
  Widget removePostBtn(BuildContext context) {
    return BlocListener<PostLogicsBloc, PostLogicsState>(
      listener: (context, state) {
        if (state is RemovePostSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          if (widget.onDetail) Navigator.pop(context);
          context.read<PostBloc>().add(PostInitialFetchEvent());
          context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
        }
      },
      child: ListTile(
        leading: const Icon(Ktweel.remove_2),
        title: const Text('Remove post'),
        onTap: () {
          if (widget.onDetail) {
            changeSystemThemeOnPopup(
              color: Theme.of(context).colorScheme.tertiary,
              context: context,
            );
          } else {
            changeSystemThemeOnPopup(
              color: Theme.of(context).colorScheme.onTertiary,
              context: context,
            );
          }
          showDialog(
            context: context,
            builder: (context) {
              return CustomAlertDialog(
                title: 'Are you sure?',
                description:
                    'This will delete this post permanently, You cannot undo this action',
                actionBtnTxt: 'Remove',
                popBtnText: 'Cancel',
                onTap: () {
                  context.read<PostLogicsBloc>().add(
                        RemovePostEvent(
                          postId: widget.postModel.id!,
                        ),
                      );
                },
              );
            },
          ).then((value) {
            if (widget.onDetail) {
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.background,
                context: context,
              );
            } else {
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.onBackground,
                context: context,
              );
            }
          });
        },
      ),
    );
  }

// =========== Edit Post Button ===========
  Widget editPostBtn(BuildContext context) {
    return ListTile(
      leading: const Icon(Ktweel.edit),
      title: const Text('Edit post'),
      onTap: () {
        changeSystemThemeOnPopup(
          color: Theme.of(context).colorScheme.surface,
          context: context,
        );
        nextScreen(
          context,
          EditPostPage(
            description: widget.postModel.description,
            location: widget.postModel.location,
            imageUrlList: widget.postModel.mediaURL!,
            postId: widget.postModel.id!,
            onDetail: widget.onDetail,
          ),
        ).then(
          (value) {
            mySystemTheme(context);
          },
        );
      },
    );
  }

// =========== Save Unsave Button ===========
  Widget saveUnsaveBtn() {
    return BlocConsumer<PostLogicsBloc, PostLogicsState>(
      listener: (context, state) {
        if (state is SavedPostSuccessState) {
          changeSystemThemeOnPopup(
            color: Theme.of(context).colorScheme.onTertiary,
            context: context,
          );
          debugPrint('Saved post is success');
          context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
        }
        if (state is UnsavePostSuccessState) {
          debugPrint('Unsaved post is success');
          changeSystemThemeOnPopup(
            color: Theme.of(context).colorScheme.onTertiary,
            context: context,
          );
          context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
        }
      },
      builder: (context, state) {
        return ListTile(
          leading: isSaved
              ? const Icon(Ktweel.unbookmark, size: 22)
              : const Icon(Ktweel.bookmark, size: 22),
          onTap: () {
            if (isSaved) {
              isSaved = false;
              context
                  .read<PostLogicsBloc>()
                  .add(UnsavePostEvent(postId: widget.postModel.id!));
            } else {
              isSaved = true;
              context
                  .read<PostLogicsBloc>()
                  .add(SavePostEvent(postId: widget.postModel.id!));
            }
          },
          title: isSaved ? const Text('Unsave') : const Text('Save'),
        );
      },
    );
  }
}
