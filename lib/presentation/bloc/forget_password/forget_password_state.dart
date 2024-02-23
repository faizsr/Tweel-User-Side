part of 'forget_password_bloc.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetSentOtpLoadingState extends ForgetPasswordState {}

class ForgetSentOtpSuccessState extends ForgetPasswordState {}

class ForgetUserNotExistState extends ForgetPasswordState {}

class ForgetSentOtpErrorState extends ForgetPasswordState {}

class ForgetResetPasswordLoadingState extends ForgetPasswordState {}

class ForgetResetPasswordSuccessState extends ForgetPasswordState {}

class ForgetResetPasswordInvalidOtpState extends ForgetPasswordState {}

class ForgetResetPasswordErrorState extends ForgetPasswordState {}
