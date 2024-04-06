part of 'post_by_id_bloc.dart';

@immutable
sealed class PostByIdEvent {}

class FetchPostByIdEvent extends PostByIdEvent {
  final String postId;

  FetchPostByIdEvent({
    required this.postId,
  });
}
