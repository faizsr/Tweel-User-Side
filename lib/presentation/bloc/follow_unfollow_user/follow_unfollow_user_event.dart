part of 'follow_unfollow_user_bloc.dart';

@immutable
sealed class FollowUnfollowUserEvent {}

class FollowUserEvent extends FollowUnfollowUserEvent {
  final String userId;
  final String name;

  FollowUserEvent({
    required this.userId,
    required this.name,
  });
}

class UnfollowUserEvent extends FollowUnfollowUserEvent {
  final String userId;
  final String name;

  UnfollowUserEvent({
    required this.userId,
    required this.name,
  });
}
