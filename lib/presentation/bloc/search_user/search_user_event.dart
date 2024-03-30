part of 'search_user_bloc.dart';

@immutable
sealed class SearchUsrEvent {}

class SearchUserEvent extends SearchUsrEvent {
  final String query;

  SearchUserEvent({
    required this.query,
  });
}
