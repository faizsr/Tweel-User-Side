part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class UserSignInEvent extends SignInEvent {
  final String username;
  final String password;

  UserSignInEvent({
    required this.username,
    required this.password,
  });
}
