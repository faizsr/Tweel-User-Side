import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:tweel_social_media/presentation/pages/profile/connection_list/connection_list_page.dart';

class PostFollowCountWidget extends StatelessWidget {
  const PostFollowCountWidget({
    super.key,
    required this.postsList,
    required this.userModel,
    required this.currentUserModel,
  });

  final List<PostModel> postsList;
  final UserModel userModel;
  final UserModel currentUserModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowUnfollowUserBloc, FollowUnfollowUserState>(
      builder: (context, state) {
        if (state is FollowedUserState) {
          debugPrint('state is follow');
          if (!userModel.followers!.contains(currentUserModel)) {
            userModel.followers!.add(currentUserModel);
            debugPrint(
                'Followers List Length After Adding: ${userModel.followers!.length}');
            debugPrint(
                'Followers List Length After Adding: ${state.followersList.length}');
          }
        }
        if (state is UnfollowedUserState) {
          debugPrint('state is unfollow');
          if (userModel.followers!.contains(currentUserModel)) {
            userModel.followers!.remove(currentUserModel);
            debugPrint(
                'Followers List Length After Removing: ${userModel.followers!.length}');
            debugPrint(
                'Followers List Length After Removing: ${state.followersList.length}');
          }
        }
        return Container(
          height: 90,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            border: Border.all(
                width: 0.5, color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 40,
                color: Colors.black.withOpacity(0.05),
              )
            ],
          ),
          child: Row(
            children: [
              _userPostFollowCountCard(
                count: '${postsList.length}',
                title: 'POSTS',
                onTap: () {},
              ),
              Container(
                height: double.infinity,
                width: 0.5,
                color: Theme.of(context).colorScheme.primary,
              ),
              _userPostFollowCountCard(
                count: '${userModel.followers!.length}',
                title: 'FOLLOWERS',
                onTap: () {
                  nextScreen(
                    context,
                    ConnectionListPage(
                      selectedPage: 0,
                      followers: userModel.followers!,
                      following: userModel.following!,
                    ),
                  );
                },
              ),
              Container(
                height: double.infinity,
                width: 0.5,
                color: Theme.of(context).colorScheme.primary,
              ),
              _userPostFollowCountCard(
                count: '${userModel.following!.length}',
                title: 'FOLLOWING',
                onTap: () {
                  nextScreen(
                    context,
                    ConnectionListPage(
                      selectedPage: 1,
                      followers: userModel.followers!,
                      following: userModel.following!,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _userPostFollowCountCard(
      {required String count, required String title, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              style: const TextStyle(fontSize: 22),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}