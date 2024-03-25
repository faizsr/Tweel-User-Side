part of 'search_follower_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchFollowerInitial extends SearchState {}

class SearchFollowerLoadingState extends SearchState {}

class SearchFollowerLoadedState extends SearchState {
  final List followers;

  SearchFollowerLoadedState({
    required this.followers,
  });
}

class SearchFollowingLoadingState extends SearchState {}

class SearchFollowingLoadedState extends SearchState {
  final List following;

  SearchFollowingLoadedState({
    required this.following,
  });
}
