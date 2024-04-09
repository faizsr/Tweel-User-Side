part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

class CommentAddedState extends CommentState {
  final CommentModel commentModel;

  CommentAddedState({
    required this.commentModel,
  });
}

class CommentDeletedState extends CommentState {}
