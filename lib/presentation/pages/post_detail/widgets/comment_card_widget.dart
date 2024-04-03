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
    return Column(
      children: [
        BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            return BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is UserDetailFetchingSucessState) {
                  return Slidable(
                    enabled: commentModel.user.id == state.userDetails.id,
                    endActionPane: ActionPane(
                      extentRatio: 0.15,
                      motion: const ScrollMotion(),
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<CommentBloc>().add(DeleteCommentEvent(
                                  postId: postModel.id!,
                                  commentId: commentModel.id,
                                  postModel: postModel,
                                ));
                          },
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              radius: 20,
                              child: const Icon(
                                Ktweel.remove_2,
                                size: 20,
                                color: lWhite,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              debugPrint('Go to profile');
                              changeSystemThemeOnPopup(
                                color: Theme.of(context).colorScheme.surface,
                                context: context,
                              );
                              nextScreen(
                                  context,
                                  UserProfilePage(
                                    userId: commentModel.user.id!,
                                    isCurrentUser: false,
                                  )).then((value) {
                                changeSystemThemeOnPopup(
                                  color: Theme.of(context).colorScheme.surface,
                                  context: context,
                                );
                              });
                              context.read<UserByIdBloc>().add(
                                  FetchUserByIdEvent(
                                      userId: commentModel.user.id!));
                            },
                            child: CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                  commentModel.user.profilePicture!),
                            ),
                          ),
                          kWidth(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                commentModel.user.fullName!,
                                style: const TextStyle(fontSize: 15),
                              ),
                              kHeight(6),
                              Text(
                                commentModel.comment,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 13,
                                ),
                              ),
                              kHeight(10),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.heart,
                                    size: 18,
                                    color:
                                        Theme.of(context).colorScheme.onSecondary,
                                  ),
                                  kWidth(5),
                                  Text(
                                    "0",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontVariations: fontWeightW500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
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
                                timeAgo(
                                    DateTime.parse(commentModel.createdDate)),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
            );
          },
        ),
      ],
    );
  }
}
