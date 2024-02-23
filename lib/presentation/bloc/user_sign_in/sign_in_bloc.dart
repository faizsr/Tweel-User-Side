import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/domain/repos/auth_repo.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<UserSignInEvent>(userSignInEvent);
  }

  FutureOr<void> userSignInEvent(
      UserSignInEvent event, Emitter<SignInState> emit) async {
    emit(UserSignInLoadingState());
    String response = await AuthRepo.userSignIn(
        username: event.username, password: event.password);
    if (response == 'success') {
      emit(UserSignInSuccessState());
    } else if (response == 'invalid-username') {
      print('yes invalid username');
      emit(InvalidUsernameErrorState());
    } else if (response == 'invalid-password') {
      print('yes invalid password');
      emit(InvalidPasswordErrorState());
    } else {
      emit(UserSignInErrorState());
    }
  }
}
