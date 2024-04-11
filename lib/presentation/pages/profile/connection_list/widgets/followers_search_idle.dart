import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/presentation/widgets/user_list_tile.dart';

class FollowSearchIdle extends StatelessWidget {
  const FollowSearchIdle({
    super.key,
    required this.followers,
    required this.isCurrentUser,
  });

  final List followers;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return followers.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            shrinkWrap: true,
            itemCount: followers.length,
            itemBuilder: (context, index) {
              return UserListTile(
                onTap: () {
                  context
                      .read<UserByIdBloc>()
                      .add(FetchUserByIdEvent(userId: followers[index]['_id']));
                  nextScreen(
                    context,
                    UserProfilePage(
                      userId: followers[index]['_id'],
                      isCurrentUser: false,
                    ),
                  );
                },
                username: followers[index]['username'].toString(),
                profileUrl: followers[index]['profile_picture'].toString(),
                fullname: followers[index]['fullname'].toString(),
              );
            },
          )
        : Center(
            child: Text(
              isCurrentUser
                  ? "No followers yet. Start connecting!"
                  : 'No followers found!!',
              style: const TextStyle(fontSize: 15),
            ),
          );
  }
}
