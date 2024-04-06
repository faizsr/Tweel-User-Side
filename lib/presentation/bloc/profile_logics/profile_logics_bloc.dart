import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/repository/cloud_repo/cloud_repo.dart';
import 'package:tweel_social_media/domain/repository/profile_repo/profile_repo.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'profile_logics_event.dart';
part 'profile_logics_state.dart';

class ProfileLogicsBloc extends Bloc<ProfileLogicsEvent, ProfileLogicsState> {
  ProfileLogicsBloc() : super(ProfileLogicsInitial()) {
    on<EditUserDetailEvent>(editUserDetailEvent);
    on<ChangeAccountTypeEvent>(changeAccountTypeEvent);
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

  FutureOr<void> changeAccountTypeEvent(
      ChangeAccountTypeEvent event, Emitter<ProfileLogicsState> emit) async {
    emit(ChangeAccountTypeLoadingState());
    String response = await ProfileRepo.changeAccountType(event.accountType);
    if (response == 'success') {
      print('success');
      emit(ChangeAccountTypeSuccessState());
    } else {
      emit(ChangeAccountTypeErrorState());
    }
  }
}
