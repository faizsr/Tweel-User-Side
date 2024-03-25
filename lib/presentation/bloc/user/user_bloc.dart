import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/user_repo/user_repo.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial() ) {
    on<FetchAllUserEvent>(fetchAllUsersEvent);
  }

  FutureOr<void> fetchAllUsersEvent(
      FetchAllUserEvent event, Emitter<UserState> emit) async {
    emit(UserDetailFetchingLoadingState());
    List<UserModel> users = await UserRepo.fetchUserDetails();
    if (users.isNotEmpty) {
      emit(UserDetailFetchingSuccessState(users: users));
    } else {
      emit(UserDetailFetchingErrorState());
    }
  }

}
