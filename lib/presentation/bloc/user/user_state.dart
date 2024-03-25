part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

class UserDetailFetchingLoadingState extends UserState {}

class UserDetailFetchingSuccessState extends UserState {
  final List<UserModel> users;

  UserDetailFetchingSuccessState({
    required this.users,
  });
}

class UserDetailFetchingErrorState extends UserState {}
