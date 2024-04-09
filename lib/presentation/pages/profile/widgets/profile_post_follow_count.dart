import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/profile/connection_list/connection_list_page.dart';

class ProfilePostFollowCountWidget extends StatelessWidget {
  const ProfilePostFollowCountWidget(
      {super.key,
      required this.postsList,
      required this.userModel,
      this.isCurrentUser = false});

  final List<PostModel> postsList;
  final UserModel userModel;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        border:
            Border.all(width: 1, color: theme.colorScheme.outline),
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
            count: postsList.length.toString(),
            title: 'POSTS',
            onTap: () {},
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: theme.colorScheme.outline,
          ),
          _userPostFollowCountCard(
            count: '${userModel.followers!.length}',
            title: 'FOLLOWERS',
            onTap: () {
              changeSystemThemeOnPopup(
                color: theme.colorScheme.surface,
                context: context,
              );
              nextScreen(
                context,
                ConnectionListPage(
                  selectedPage: 0,
                  followers: userModel.followers!,
                  following: userModel.following!,
                  isCurrentUser: isCurrentUser,
                  userId: userModel.id!,
                ),
              ).then((value) => mySystemTheme(context));
            },
          ),
          Container(
            height: double.infinity,
            width: 1,
            color: theme.colorScheme.outline,
          ),
          _userPostFollowCountCard(
            count: '${userModel.following!.length}',
            title: 'FOLLOWING',
            onTap: () {
              changeSystemThemeOnPopup(
                color: theme.colorScheme.surface,
                context: context,
              );
              nextScreen(
                context,
                ConnectionListPage(
                  selectedPage: 1,
                  followers: userModel.followers!,
                  following: userModel.following!,
                  isCurrentUser: isCurrentUser,
                  userId: userModel.id!,
                ),
              ).then((value) => mySystemTheme(context));
            },
          ),
        ],
      ),
    );
  }
}

Widget _userPostFollowCountCard(
    {required String count, required String title, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
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
