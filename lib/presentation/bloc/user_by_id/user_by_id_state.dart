part of 'user_by_id_bloc.dart';

@immutable
sealed class UserByIdState {}

final class UserByIdInitial extends UserByIdState {}

class FetchUserByIdLoadingState extends UserByIdState {}

class FetchUserByIdSuccessState extends UserByIdState {
  final UserModel userModel;
  final List<PostModel> posts;

  FetchUserByIdSuccessState({
    required this.userModel,
    required this.posts,
  });
}

class FetchUserByIdErrorState extends UserByIdState {}
