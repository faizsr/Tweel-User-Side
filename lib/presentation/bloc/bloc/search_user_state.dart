part of 'search_user_bloc.dart';

@immutable
sealed class SearchUserState {}

final class SearchUserInitial extends SearchUserState {}

class SearchResultLoadingState extends SearchUserState {}

class SearchResultSuccessState extends SearchUserState {
  final List<UserModel> users;

  SearchResultSuccessState({
    required this.users,
  });
}

class SearchResultErrorState extends SearchUserState {}
