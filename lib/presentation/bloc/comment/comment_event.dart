part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class AddCommentEvent extends CommentEvent {
  final String postId;
  final String comment;
  final PostModel postModel;
  final UserModel userModel;

  AddCommentEvent({
    required this.postId,
    required this.comment,
    required this.postModel,
    required this.userModel,
  });
}

class DeleteCommentEvent extends CommentEvent {
  final String postId;
  final String commentId;
  final PostModel postModel;

  DeleteCommentEvent({
    required this.postId,
    required this.commentId,
    required this.postModel,
  });
}
