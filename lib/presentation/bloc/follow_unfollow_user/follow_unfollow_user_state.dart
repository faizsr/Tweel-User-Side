part of 'follow_unfollow_user_bloc.dart';

@immutable
sealed class FollowUnfollowUserState {}

final class FollowUnfollowUserInitial extends FollowUnfollowUserState {}

class FollowedUserState extends FollowUnfollowUserState {
  final List<String> followersList;
  final List<String> followingList;

  FollowedUserState({
    required this.followersList,
    required this.followingList,
  });
}

class UnfollowedUserState extends FollowUnfollowUserState {
  final List<String> followersList;
  final List<String> followingList;

  UnfollowedUserState({
    required this.followersList,
    required this.followingList,
  });
}
