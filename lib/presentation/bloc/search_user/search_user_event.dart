part of 'search_user_bloc.dart';

@immutable
sealed class SearchUsrEvent {}

class SearchUserEvent extends SearchUsrEvent {
  final String query;
  final bool onMessage;

  SearchUserEvent({
    required this.query,
    this.onMessage = false,
  });
}
