import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/domain/repository/user_repo/user_repo.dart';

part 'follow_unfollow_user_event.dart';
part 'follow_unfollow_user_state.dart';

class FollowUnfollowUserBloc
    extends Bloc<FollowUnfollowUserEvent, FollowUnfollowUserState> {
  FollowUnfollowUserBloc() : super(FollowUnfollowUserInitial()) {
    on<FollowUserEvent>(followUserEvent);
    on<UnfollowUserEvent>(unfollowUserEvent);
  }

  FutureOr<void> followUserEvent(
      FollowUserEvent event, Emitter<FollowUnfollowUserState> emit) async {
    FollowUnfollowModel response = await UserRepo.followUser(event.userId);
    if (response.message == 'success') {
      debugPrint('Followed user: ${event.name} ${event.userId}');
      emit(FollowedUserState(
        followersList: response.followers,
        followingList: response.following,
      ));
    }
  }

  FutureOr<void> unfollowUserEvent(
      UnfollowUserEvent event, Emitter<FollowUnfollowUserState> emit) async {
    FollowUnfollowModel response = await UserRepo.unfollowUser(event.userId);
    if (response.message == 'success') {
      debugPrint('Unfollowed user: ${event.name} ${event.userId}');
      emit(UnfollowedUserState(
        followersList: response.followers,
        followingList: response.following,
      ));
    }
  }
}
