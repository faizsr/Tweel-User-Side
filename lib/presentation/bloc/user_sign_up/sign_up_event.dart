part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class UserSignUpEvent extends SignUpEvent {
  final UserModel user;

  UserSignUpEvent({
    required this.user,
  });
}

class UserOtpVerificationEvent extends SignUpEvent {
  final String email;

  UserOtpVerificationEvent({
    required this.email,
  });
}
