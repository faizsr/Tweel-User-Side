import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/follow_unfollow_user/follow_unfollow_user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/search_follower/search_follower_bloc.dart';
import 'package:tweel_social_media/presentation/pages/profile/connection_list/widgets/following_search_idle.dart';
import 'package:tweel_social_media/presentation/pages/profile/connection_list/widgets/following_search_result.dart';

class FollowingView extends StatelessWidget {
  const FollowingView({
    super.key,
    required this.following,
    required this.isCurrentUser,
  });

  final List following;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FollowUnfollowUserBloc, FollowUnfollowUserState>(
      listener: (context, state) {
        
      },
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchFollowingLoadedState) {
            return state.following.isEmpty
                ? const Center(
                    child: Text('No users found'),
                  )
                : FollowingSearchResult(
                    state: state,
                  );
          }
          return FollowingSearchIdle(
            following: following,
            isCurrentUser: isCurrentUser,
          );
        },
      ),
    );
  }
}
