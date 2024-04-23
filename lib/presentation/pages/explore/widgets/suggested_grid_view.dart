import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/loading_flw_btn.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/follow_btn_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class SuggestedPeopleGridView extends StatelessWidget {
  const SuggestedPeopleGridView({
    super.key,
    required this.theme,
    required this.state,
    this.maxCount,
    this.isDetail = false,
  });

  final ThemeData theme;
  final UserDetailFetchingSuccessState state;
  final int? maxCount;
  final bool isDetail;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      physics: isDetail
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      shrinkWrap: true,
      reverse: true,
      crossAxisCount: 2,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      itemCount: maxCount ?? state.users.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            debugPrint('Go to profile');
            nextScreen(
                context,
                UserProfilePage(
                  userId: state.users[index].id!,
                  isCurrentUser: false,
                )).then(
              (value) => mySystemTheme(context),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              boxShadow: kBoxShadow,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.colorScheme.onSurface,
                  backgroundImage: state.users[index].profilePicture == ""
                      ? Image.asset(profilePlaceholder).image
                      : NetworkImage(state.users[index].profilePicture!),
                ),
                kHeight(10),
                Text(state.users[index].fullName!),
                kHeight(2),
                Text(
                  '@${state.users[index].username!.toLowerCase()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                kHeight(10),
                _followBtn(index)
              ],
            ),
          ),
        );
      },
    );
  }

  BlocBuilder<ProfileBloc, ProfileState> _followBtn(int index) {
    void followUnfollowFunction(
        UserModel currentUserModel, UserModel user, bool? isUnfollowing) {
      if (user.followers!.contains(currentUserModel) || isUnfollowing!) {
        state.users[index].followers!.removeWhere(
          (element) => element['_id'] == currentUserModel.id,
        );
      } else {
        state.users[index].followers!.add(currentUserModel.toJson());
      }
    }

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileFetchingSucessState) {
          return SizedBox(
            height: 35,
            width: double.infinity,
            child: FollowButton(
              userModel: state.users[index],
              onFollowUnfollow: followUnfollowFunction,
            ),
          );
        }
        return const LoadingFollowBtn();
      },
    );
  }
}
