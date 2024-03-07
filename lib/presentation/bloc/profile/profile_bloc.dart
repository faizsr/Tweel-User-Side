import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/profile_repo/profile_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UserDetailInitialFetchEvent>(userDetailInitialFetchEvent);
  }

  FutureOr<void> userDetailInitialFetchEvent(
      UserDetailInitialFetchEvent event, Emitter<ProfileState> emit) async {
    emit(UserDetailFetchingLoadingState());
    UserModel? userDetails = await ProfileRepo.fetchUserDetails();
    if (userDetails != null) {
      emit(UserDetailFetchingSucessState(userDetails: userDetails));
    } else {
      emit(UserDetailFetchingErrorState());
    }
  }
}
