import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/repos/auth_repo.dart';

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
    String response = await AuthRepo.userSignUp(user: event.user);
    debugPrint('response: $response');
    if (response == 'success') {
      emit(UserSignUpSuccessState());
    }
    if (response == 'invalid-otp') {
      debugPrint('Invalid OTP');
      emit(UserOtpErrorState());
    }
    if (response == 'username-exists') {
      print('emittting');
      emit(UserAlreadyExistsState());
    }
    emit(UserSignUpErrorState());
  }

  FutureOr<void> userOtpVerificationEvent(
      UserOtpVerificationEvent event, Emitter<SignUpState> emit) async {
    emit(UserOtpLoadingState());
    String response = await AuthRepo.userVerifyOtp(email: event.email);
    debugPrint('isVerified $response');
    if (response == 'success') {
      debugPrint(response);
      emit(UserOtpSuccessState());
    } else if (response == 'already-exists') {
      debugPrint(response);
      emit(UserAlreadyExistsState());
    } else {
      debugPrint(response);
      emit(UserOtpErrorState());
    }
  }
}
