import 'dart:async';
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/auth_repo/auth_repo.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<UserSignInEvent>(userSignInEvent);
  }

  FutureOr<void> userSignInEvent(
      UserSignInEvent event, Emitter<SignInState> emit) async {
    emit(UserSignInLoadingState());
    SignInResult response = await AuthRepo.userSignIn(
        username: event.username, password: event.password);
    if (response.status == 'success') {
      final userModel = UserModel.fromJson(response.responseBody);
      emit(UserSignInSuccessState(userModel: userModel));
    } else if (response.status == 'invalid-username') {
      debugPrint('yes invalid username');
      emit(InvalidUsernameErrorState());
    } else if (response.status == 'invalid-password') {
      debugPrint('yes invalid password');
      emit(InvalidPasswordErrorState());
    } else if (response.status == 'blocked-by-admin') {
      emit(BlockedbyAdminErrorState());
    } else {
      emit(UserSignInErrorState());
    }
  }
}
