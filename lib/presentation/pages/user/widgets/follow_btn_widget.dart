import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({
    super.key,
    required this.userModel,
    // required this.height,
    // required this.width,
  });

  final UserModel userModel;
  // final double height;
  // final double width;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  Set<String> followersIds = {};
  Set<String> followingIds = {};

  @override
  void initState() {
    followersIds = widget.userModel.followers!
        .map((user) => user['_id'].toString())
        .toSet();
    followingIds = widget.userModel.following!
        .map((user) => user['_id'].toString())
        .toSet();
    debugPrint('Followers User ids:  $followersIds');
    debugPrint('Followers User ids:  ${followersIds.length}');
    debugPrint('Following User ids:  ${followingIds.length}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocBuilder(
      blocs: [
        context.watch<FollowUnfollowUserBloc>(),
        context.watch<ProfileBloc>()
      ],
      builder: (context, state) {
        // var state1 = state[0];
        var state2 = state[1];
        if (state2 is UserDetailFetchingSucessState) {
          bool isFollowing = followersIds.contains(state2.userDetails.id);
          bool isFollowedByUser = followingIds.contains(state2.userDetails.id);
          return CustomOutlinedBtn(
            // height: widget.height,
            // width: widget.width,
            onPressed: () {
              if (isFollowing) {
                debugPrint('Unfollowed');
                followersIds.remove(state2.userDetails.id);
                // followingIds.remove(state2.userDetails.id);
                debugPrint('User ids after removing: ${followersIds.length}');
                context.read<FollowUnfollowUserBloc>().add(
                      UnfollowUserEvent(
                        userId: widget.userModel.id!,
                        name: widget.userModel.fullName!,
                      ),
                    );
              } else if (isFollowedByUser) {
                debugPrint('Followed');
                followersIds.add(state2.userDetails.id!);
                // followingIds.add(state2.userDetails.id!);
                debugPrint('User ids after adding: ${followersIds.length}');
                context.read<FollowUnfollowUserBloc>().add(
                      FollowUserEvent(
                        userId: widget.userModel.id!,
                        name: widget.userModel.fullName!,
                      ),
                    );
              } else {
                debugPrint('Followed');
                followersIds.add(state2.userDetails.id!);
                // followingIds.add(state2.userDetails.id!);
                debugPrint('User ids after adding: ${followersIds.length}');
                context.read<FollowUnfollowUserBloc>().add(
                      FollowUserEvent(
                        userId: widget.userModel.id!,
                        name: widget.userModel.fullName!,
                      ),
                    );
              }
            },
            btnText: isFollowing
                ? 'UNFOLLOW'
                : isFollowedByUser
                    ? 'FOLLOW BACK'
                    : 'FOLLOW',
          );
        }
        return Container();
      },
    );
  }
}