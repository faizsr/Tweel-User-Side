part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

class CommentAddedState extends CommentState {}

class CommentDeletedState extends CommentState {}
