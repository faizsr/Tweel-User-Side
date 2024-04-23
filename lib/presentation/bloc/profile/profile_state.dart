part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

class ProfileFetchingLoadingState extends ProfileState {}

class ProfileFetchingSucessState extends ProfileState {
  final UserModel userDetails;
  final List<PostModel> posts;

  ProfileFetchingSucessState({
    required this.userDetails,
    required this.posts,
  });
}

class ProfileFetchingErrorState extends ProfileState {}
