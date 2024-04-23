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

  @override
  Widget build(BuildContext context) {
    return widget.following.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            shrinkWrap: true,
            itemCount: widget.following.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context.read<UserByIdBloc>().add(FetchUserByIdEvent(
                      userId: widget.following[index]['_id']));
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
                    backgroundImage:
                        widget.following[index]['profile_picture'] == ""
                            ? Image.asset(profilePlaceholder).image
                            : NetworkImage(
                                widget.following[index]['profile_picture'],
                              ),
                  ),
                  title: Text(
                    widget.following[index]['fullname'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontVariations: fontWeightW500,
                      height: 1.5,
                    ),
                  ),
                  minVerticalPadding: 18,
                  subtitle: Text(
                    widget.following[index]['username'],
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
