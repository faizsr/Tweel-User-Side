import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/presentation/widgets/user_list_tile.dart';

class FollowSearchIdle extends StatelessWidget {
  const FollowSearchIdle({
    super.key,
    required this.followers,
  });

  final List followers;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      shrinkWrap: true,
      itemCount: followers.length,
      itemBuilder: (context, index) {
        return UserListTile(
          onTap: () {
            context
                .read<UserByIdBloc>()
                .add(FetchUserByIdEvent(userId: followers[index]['_id']));
            nextScreen(context, const UserProfilePage());
          },
          username: followers[index]['username'],
          profileUrl: followers[index]['profile_picture'],
          fullname: followers[index]['fullname'],
        );
      },
    );
  }
}
