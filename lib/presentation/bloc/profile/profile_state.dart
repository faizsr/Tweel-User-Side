part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class UserDetailFetchingLoadingState extends ProfileState {}

class UserDetailFetchingSucessState extends ProfileState {
  final UserModel userDetails;

  UserDetailFetchingSucessState({
    required this.userDetails,
  });
}

class UserDetailFetchingErrorState extends ProfileState {}
