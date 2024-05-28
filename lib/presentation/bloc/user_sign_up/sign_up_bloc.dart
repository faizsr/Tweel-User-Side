import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/repository/auth_repo/auth_repo.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<UserSignUpEvent>(userSignUpEvent);
    on<UserOtpVerificationEvent>(userOtpVerificationEvent);
  }

  FutureOr<void> userSignUpEvent(
      UserSignUpEvent event, Emitter<SignUpState> emit) async {
    emit(UserSignUpLoadingState());
    SignUpResult response = await AuthRepo.userSignUp(user: event.user);
    if (response.status == 'success') {
      emit(UserSignUpSuccessState());
    } else if (response.status == 'invalid-otp') {
      emit(UserOtpErrorState());
    } else if (response.status == 'username-exists') {
      emit(UsernameExistsErrorState());
    } else if (response.status == 'email-exists') {
      emit(EmailExistsErrorState());
    } else if (response.status == 'phoneno-exists') {
      emit(PhonenoExistsErrorState());
    } else {
      emit(UserSignUpErrorState());
    }
  }

  FutureOr<void> userOtpVerificationEvent(
      UserOtpVerificationEvent event, Emitter<SignUpState> emit) async {
    emit(UserOtpLoadingState());
    String response = await AuthRepo.userVerifyOtp(email: event.email);
    if (response == 'success') {
      emit(UserOtpSuccessState());
    } else if (response == 'already-exists') {
      emit(UsernameExistsErrorState());
    } else {
      emit(UserOtpErrorState());
    }
  }
}
