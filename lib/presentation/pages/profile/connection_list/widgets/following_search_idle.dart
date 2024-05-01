import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class FollowingSearchIdle extends StatefulWidget {
  const FollowingSearchIdle({
    super.key,
    required this.following,
    required this.isCurrentUser,
  });

  final List following;
  final bool isCurrentUser;

  @override
  State<FollowingSearchIdle> createState() => _FollowingSearchIdleState();
}

class _FollowingSearchIdleState extends State<FollowingSearchIdle> {
  bool isFollowing = false;
  Set<String> userIds = {};

  @override
  Widget build(BuildContext context) {
    return widget.following.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            shrinkWrap: true,
            itemCount: widget.following.length,
            itemBuilder: (context, index) {
              final following = widget.following[index];
              return InkWell(
                onTap: () {
                  context
                      .read<UserByIdBloc>()
                      .add(FetchUserByIdEvent(userId: following['_id']));
                  nextScreen(
                      context,
                      UserProfilePage(
                        userId: widget.following[index]['_id'],
                        isCurrentUser: false,
                      ));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: following['profile_picture'] == ""
                        ? Image.asset(profilePlaceholder).image
                        : NetworkImage(
                            following['profile_picture'],
                          ),
                  ),
                  title: Text(
                    following['fullname'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontVariations: fontWeightW500,
                      height: 1.5,
                    ),
                  ),
                  minVerticalPadding: 18,
                  subtitle: Text(
                    following['username'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  trailing: SizedBox(
                    width: 94,
                    height: 30,
                    child: BlocConsumer<FollowUnfollowUserBloc,
                        FollowUnfollowUserState>(
                      listener: (context, state) {
                        if (state is UnfollowedUserState) {
                          // print('unfollowd state');
                          isFollowing = false;
                        }
                      },
                      builder: (context, state) {
                        return CustomOutlinedBtn(
                          onPressed: () {
                            UserModel user =
                                UserModel.fromJson(widget.following[index]);
                            context.read<FollowUnfollowUserBloc>().add(
                                  UnfollowUserEvent(
                                    userId: user.id ?? '',
                                    name: user.fullName ?? '',
                                  ),
                                );
                          },
                          btnText: state is UnfollowedUserState
                              ? isFollowing
                                  ? 'UNFOLLOW'
                                  : 'FOLLOW'
                              : 'UNFOLLOW',
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
              widget.isCurrentUser
                  ? "You haven't followed anyone yet."
                  : "No following found!!",
              style: const TextStyle(fontSize: 15),
            ),
          );
  }
}
