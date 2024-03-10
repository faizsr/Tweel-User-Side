part of 'like_unlike_post_bloc.dart';

@immutable
sealed class LikeUnlikePostEvent {}

class LikePostEvent extends LikeUnlikePostEvent {
  final String postId;

  LikePostEvent({
    required this.postId,
  });
}

class UnlikePostEvent extends LikeUnlikePostEvent {
  final String postId;

  UnlikePostEvent({
    required this.postId,
  });
}
