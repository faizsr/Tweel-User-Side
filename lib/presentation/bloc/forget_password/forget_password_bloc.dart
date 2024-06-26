import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/domain/repository/forget_repo/forget_repo.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetSentOtpEvent>(forgetSentOtp);
    on<ForgetResetPasswordEvent>(forgetResetPasswordEvent);
  }

  FutureOr<void> forgetSentOtp(
      ForgetSentOtpEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetSentOtpLoadingState());
    String response = await ForgetRepo.forgetSendOtp(email: event.email);
    if (response == 'success') {
      emit(ForgetSentOtpSuccessState());
    } else if (response == 'user-not-found') {
      emit(ForgetUserNotExistState());
    } else {
      emit(ForgetSentOtpErrorState());
    }
  }

  FutureOr<void> forgetResetPasswordEvent(
      ForgetResetPasswordEvent event, Emitter<ForgetPasswordState> emit) async {
    emit(ForgetResetPasswordLoadingState());
    String response = await ForgetRepo.resetPassword(
        email: event.email, otp: event.otp, password: event.password);
    if (response == 'success') {
      emit(ForgetResetPasswordSuccessState());
    } else if (response == 'invalid-otp') {
      emit(ForgetResetPasswordInvalidOtpState());
    } else {
      emit(ForgetResetPasswordErrorState());
    }
  }
}
