part of 'saved_posts_bloc.dart';

@immutable
sealed class SavedPostsState {}

final class SavedPostsInitial extends SavedPostsState {}

class FetchAllSavedPostLoadingState extends SavedPostsState {}

class FetchAllSavedPostSuccessState extends SavedPostsState {
  final List<PostModel> savedPosts;

  FetchAllSavedPostSuccessState({
    required this.savedPosts,
  });
}

class FetchAllSavedPostErrorState extends SavedPostsState {}
