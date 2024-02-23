part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordEvent {}

class ForgetSentOtpEvent extends ForgetPasswordEvent {
  final String email;

  ForgetSentOtpEvent({
    required this.email,
  });
}

class ForgetResetPasswordEvent extends ForgetPasswordEvent {
  final String email;
  final String otp;
  final String password;

  ForgetResetPasswordEvent({
    required this.email,
    required this.otp,
    required this.password,
  });
}
