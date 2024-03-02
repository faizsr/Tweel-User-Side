part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

class UserSignInLoadingState extends SignInState {}

class UserSignInSuccessState extends SignInState {
  final UserModel userModel;

  UserSignInSuccessState({
    required this.userModel,
  });
}

class InvalidUsernameErrorState extends SignInState {}

class InvalidPasswordErrorState extends SignInState {}

class BlockedbyAdminErrorState extends SignInState {}

class UserSignInErrorState extends SignInState {}
