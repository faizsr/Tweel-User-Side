part of 'search_follower_bloc.dart';

@immutable
sealed class SearchEvent {}

class SearchFollowerEvent extends SearchEvent {
  final String query;
  final List followers;

  SearchFollowerEvent({
    required this.query,
    required this.followers,
  });
}

class SearchFollowingEvent extends SearchEvent {
  final String query;
  final List following;

  SearchFollowingEvent({
    required this.query,
    required this.following,
  });
}
