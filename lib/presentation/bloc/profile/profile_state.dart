part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class UserProfileInitialState extends ProfileState {}

class UserDetailFetchingLoadingState extends ProfileState {}

class UserDetailFetchingSucessState extends ProfileState {
  final UserModel userDetails;
  final List<PostModel> posts;

  UserDetailFetchingSucessState({
    required this.userDetails,
    required this.posts,
  });
}

class UserDetailFetchingErrorState extends ProfileState {}
