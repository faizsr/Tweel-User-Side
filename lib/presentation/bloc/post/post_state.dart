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

class CreatePostSuccessState extends PostState {}

class CreatePostErrorState extends PostState {}

class UploadImageLoadingState extends PostState {}

class UploadImageSuccessState extends PostState {
  final List<String> imagePathList;

  UploadImageSuccessState({
    required this.imagePathList,
  });
}

class UploadImageErrorState extends PostState {}
