import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/cloud_repo/cloud_repo.dart';
import 'package:tweel_social_media/domain/profile_repo/profile_repo.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'profile_logics_event.dart';
part 'profile_logics_state.dart';

class ProfileLogicsBloc extends Bloc<ProfileLogicsEvent, ProfileLogicsState> {
  ProfileLogicsBloc() : super(ProfileLogicsInitial()) {
    on<EditUserDetailEvent>(editUserDetailEvent);
  }
  FutureOr<void> editUserDetailEvent(
      EditUserDetailEvent event, Emitter<ProfileLogicsState> emit) async {
    emit(EditUserDetailsLoadingState());
    List<String> imageUrl = [];
    if (event.profilePicture.isNotEmpty) {
      imageUrl = await CloudRepo.uploadImage(event.profilePicture);
    }
    String response = await ProfileRepo.updateUserDetails(event.intialUser,
        event.updatedUser, imageUrl.isEmpty ? '' : imageUrl[0]);
    if (response == 'success') {
      emit(EditUserDetailsSuccessState());
    } else if (response == 'username-exists') {
      emit(EditUsernameAlreadyExistsState());
    } else {
      emit(EditUserDetailsErrorState());
    }
  }
}
