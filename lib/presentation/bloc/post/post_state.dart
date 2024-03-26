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

