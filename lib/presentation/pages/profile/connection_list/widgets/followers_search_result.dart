import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/search_follower/search_follower_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class FollowSearchResult extends StatelessWidget {
  const FollowSearchResult({
    super.key,
    required this.state,
  });

  final SearchFollowerLoadedState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      shrinkWrap: true,
      itemCount: state.followers.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context
                .read<UserByIdBloc>()
                .add(FetchUserByIdEvent(userId: state.followers[index]['_id']));
            nextScreen(context, const UserProfilePage());
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: state.followers[index]['profile_picture'] == ""
                  ? Image.asset(profilePlaceholder).image
                  : NetworkImage(state.followers[index]['profile_picture']),
            ),
            title: Text(
              state.followers[index]['fullname'],
              style: const TextStyle(
                fontSize: 15,
                fontVariations: fontWeightW500,
                height: 1.5,
              ),
            ),
            minVerticalPadding: 18,
            subtitle: Text(
              '@${state.followers[index]['username']}',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            trailing: SizedBox(
              width: 94,
              height: 30,
              child: CustomOutlinedBtn(
                height: 35,
                width: 70,
                onPressed: () {},
                btnText: 'VIEW',
              ),
            ),
          ),
        );
      },
    );
  }
}
