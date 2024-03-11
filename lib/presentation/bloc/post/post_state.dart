part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitialState extends PostState {}

class PostDetailFetchingLoadingState extends PostState {}

class PostDetailFetchingSucessState extends PostState {
  final List<PostModel> posts;

  PostDetailFetchingSucessState({
    required this.posts,
  });
}

class PostDetailFetchingErrorState extends PostState {}

class CreatePostLoadingState extends PostState {}

class CreatePostSuccessState extends PostState {
  final List<String> imagePathList;

  CreatePostSuccessState({
    required this.imagePathList,
  });
}

class CreatePostErrorState extends PostState {}

class EditPostLoadingState extends PostState {}

class EditPostSuccessState extends PostState {}

class EditPostErrorState extends PostState {}

class RemovePostLoadingState extends PostState {}

class RemovePostSuccessState extends PostState {}

class RemovePostErrorState extends PostState {}