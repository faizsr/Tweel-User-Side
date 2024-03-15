import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/cloud_repo/cloud_repo.dart';
import 'package:tweel_social_media/domain/profile_repo/profile_repo.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(UserProfileInitialState()) {
    on<UserDetailInitialFetchEvent>(userDetailInitialFetchEvent);
    on<EditUserDetailEvent>(editUserDetailEvent);
    // on<SetProfileImageEvent>(setProfileImageEvent);
  }

  FutureOr<void> userDetailInitialFetchEvent(
      UserDetailInitialFetchEvent event, Emitter<ProfileState> emit) async {
    emit(UserDetailFetchingLoadingState());
    ProfileDetailsModel? userDetails = await ProfileRepo.fetchUserDetails();
    if (userDetails != null) {
      emit(UserDetailFetchingSucessState(
        userDetails: userDetails.user,
        posts: userDetails.posts,
      ));
    } else {
      emit(UserDetailFetchingErrorState());
    }
  }

  FutureOr<void> editUserDetailEvent(
      EditUserDetailEvent event, Emitter<ProfileState> emit) async {
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
