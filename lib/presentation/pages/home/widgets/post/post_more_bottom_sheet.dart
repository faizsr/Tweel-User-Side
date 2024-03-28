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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return AnimatedContainer(
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
          saveUnsaveBtn(isDarkMode),

          // =========== If post is of current user ===========
          (widget.postModel.user!.id ?? widget.postId) == widget.userId
              ? Column(
                  children: [
                    editPostBtn(context),
                    removePostBtn(context, isDarkMode),
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
    return const ListTile(
      leading: Icon(Icons.person),
      title: Text('View account'),
    );
  }

// =========== Report Post Button ===========
  Widget reportPostBtn() {
    return const ListTile(
      leading: Icon(Icons.report_sharp),
      title: Text('Report'),
    );
  }

// =========== Remove Post Button ===========
  Widget removePostBtn(BuildContext context, bool isDarkMode) {
    return BlocListener<PostLogicsBloc, PostLogicsState>(
      listener: (context, state) {
        if (state is RemovePostSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          if (widget.onDetail) Navigator.pop(context);
          context.read<PostBloc>().add(PostInitialFetchEvent());
          context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
        }
      },
      child: ListTile(
        leading: const Icon(Icons.delete),
        title: const Text('Remove post'),
        onTap: () {
          changeSystemThemeOnPopup(color: const Color(0xFF575757));
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
          ).then((value) =>
              changeSystemThemeOnPopup(color: isDarkMode ? dBottom : lBottom));
        },
      ),
    );
  }

// =========== Edit Post Button ===========
  Widget editPostBtn(BuildContext context) {
    return BlocListener<PostLogicsBloc, PostLogicsState>(
      listener: (context, state) {
        if (state is EditPostSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          context.read<PostBloc>().add(PostInitialFetchEvent());
          context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
        }
      },
      child: ListTile(
        leading: const Icon(Icons.edit),
        title: const Text('Edit post'),
        onTap: () {
          nextScreen(
            context,
            EditPostPage(
              description: widget.postModel.description,
              location: widget.postModel.location,
              imageUrlList: widget.postModel.mediaURL!,
              postId: widget.postModel.id!,
            ),
          );
        },
      ),
    );
  }

// =========== Save Unsave Button ===========
  Widget saveUnsaveBtn(bool isDarkMode) {
    return BlocConsumer<PostLogicsBloc, PostLogicsState>(
      listener: (context, state) {
        if (state is SavedPostSuccessState) {
          changeSystemThemeOnPopup(color: isDarkMode ? dBottom : lBottom);
          debugPrint('Saved post is success');
          context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
        }
        if (state is UnsavePostSuccessState) {
          debugPrint('Unsaved post is success');
          changeSystemThemeOnPopup(color: isDarkMode ? dBottom : lBottom);
          context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
        }
      },
      builder: (context, state) {
        return ListTile(
          leading: isSaved
              ? const Icon(Icons.bookmark)
              : const Icon(Icons.bookmark_border_outlined),
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
