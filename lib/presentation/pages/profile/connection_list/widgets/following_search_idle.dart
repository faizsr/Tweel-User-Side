import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class FollowingSearchIdle extends StatelessWidget {
  const FollowingSearchIdle({
    super.key,
    required this.following,
    required this.isCurrentUser,
  });

  final List following;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return following.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            shrinkWrap: true,
            itemCount: following.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context
                      .read<UserByIdBloc>()
                      .add(FetchUserByIdEvent(userId: following[index]['_id']));
                  nextScreen(
                      context,
                      UserProfilePage(
                        userId: following[index]['_id'],
                        isCurrentUser: false,
                      ));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: following[index]['profile_picture'] == ""
                        ? Image.asset(profilePlaceholder).image
                        : NetworkImage(
                            following[index]['profile_picture'],
                          ),
                  ),
                  title: Text(
                    following[index]['fullname'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontVariations: fontWeightW500,
                      height: 1.5,
                    ),
                  ),
                  minVerticalPadding: 18,
                  subtitle: Text(
                    following[index]['username'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  trailing: SizedBox(
                    width: 94,
                    height: 30,
                    child: CustomOutlinedBtn(
                      onPressed: () {},
                      btnText: 'VIEW',
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
              isCurrentUser
                  ? "You haven’t followed anyone yet."
                  : "No following found!!",
              style: const TextStyle(fontSize: 15),
            ),
          );
  }
}
