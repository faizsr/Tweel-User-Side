import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/profile_page.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/follow_btn_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class SuggestedPeopleGridView extends StatelessWidget {
  const SuggestedPeopleGridView({
    super.key,
    required this.theme,
    required this.state,
  });

  final ThemeData theme;
  final UserDetailFetchingSuccessState state;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      shrinkWrap: true,
      crossAxisCount: 2,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemCount: 4,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            debugPrint('Go to profile');
            nextScreen(context, const UserProfilePage());
            context
                .read<UserByIdBloc>()
                .add(FetchUserByIdEvent(userId: state.users[index].id!));
          },
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              boxShadow: kBoxShadow,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: kLightGrey,
                  backgroundImage: state.users[index].profilePicture == ""
                      ? Image.asset(profilePlaceholder).image
                      : NetworkImage(
                          state.users[index].profilePicture!,
                        ),
                ),
                kHeight(10),
                Text(state.users[index].fullName!),
                Text(state.users[index].username!),
                kHeight(10),
                SizedBox(
                  height: 35,
                  width: double.infinity,
                  child: FollowButton(
                    userModel: state.users[index],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
