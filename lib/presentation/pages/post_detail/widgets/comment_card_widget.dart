import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/comment/comment_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';

class CommentCardWidget extends StatefulWidget {
  const CommentCardWidget({
    super.key,
    required this.commentModel,
    required this.postModel,
  });

  final CommentModel commentModel;
  final PostModel postModel;

  @override
  State<CommentCardWidget> createState() => _CommentCardWidgetState();
}

class _CommentCardWidgetState extends State<CommentCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileFetchingSucessState) {
              return Slidable(
                enabled: widget.commentModel.user.id == state.userDetails.id,
                endActionPane: ActionPane(
                  extentRatio: 0.15,
                  motion: const ScrollMotion(),
                  children: [
                    kWidth(10),
                    BlocBuilder<CommentBloc, CommentState>(
                      builder: (context, state) {
                        String commentId = '';
                        if (state is CommentDeletedState) {
                          widget.postModel.comments!.removeWhere(
                              (element) => element.id == commentId);
                        }

                        return InkWell(
                          onTap: () {
                            if (state is CommentAddedState) {
                              commentId = state.commentModel.id;
                            }
                            context.read<CommentBloc>().add(DeleteCommentEvent(
                                  postId: widget.postModel.id!,
                                  commentId: commentId != ''
                                      ? commentId
                                      : widget.commentModel.id,
                                  postModel: widget.postModel,
                                ));
                          },
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: theme.colorScheme.onPrimary,
                              radius: 20,
                              child: const Icon(
                                Ktweel.remove_2,
                                size: 20,
                                color: lWhite,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          debugPrint('Go to profile');
                          changeSystemThemeOnPopup(
                            color: theme.colorScheme.surface,
                            context: context,
                          );
                          nextScreen(
                              context,
                              UserProfilePage(
                                userId: widget.commentModel.user.id!,
                                isCurrentUser: false,
                              )).then((value) {
                            changeSystemThemeOnPopup(
                              color: theme.colorScheme.surface,
                              context: context,
                            );
                          });
                          context.read<UserByIdBloc>().add(FetchUserByIdEvent(
                              userId: widget.commentModel.user.id!));
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundImage:
                              widget.commentModel.user.profilePicture == ""
                                  ? Image.asset(profilePlaceholder).image
                                  : NetworkImage(
                                      widget.commentModel.user.profilePicture!),
                        ),
                      ),
                      kWidth(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.commentModel.user.fullName!,
                            style: const TextStyle(fontSize: 15),
                          ),
                          kHeight(6),
                          Text(
                            widget.commentModel.comment,
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                              fontSize: 13,
                            ),
                          ),
                          kHeight(10),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.heart,
                                size: 18,
                                color: theme.colorScheme.onSecondary,
                              ),
                              kWidth(5),
                              Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontVariations: fontWeightW500,
                                  color: theme.colorScheme.onSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            timeAgo(DateTime.parse(
                                widget.commentModel.createdDate)),
                            style: TextStyle(
                              color: theme.colorScheme.secondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
