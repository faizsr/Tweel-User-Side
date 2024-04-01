part of 'post_edit_bloc.dart';

@immutable
sealed class PostEditEvent {}

class EditPostEvent extends PostEditEvent {
  final PostModel postModel;

  EditPostEvent({
    required this.postModel,
  });
}