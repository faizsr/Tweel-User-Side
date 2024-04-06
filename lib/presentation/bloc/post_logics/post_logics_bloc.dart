import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/domain/repository/cloud_repo/cloud_repo.dart';
import 'package:tweel_social_media/domain/repository/post_repo/post_repo.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'post_logics_event.dart';
part 'post_logics_state.dart';

class PostLogicsBloc extends Bloc<PostLogicsEvent, PostLogicsState> {
  PostLogicsBloc() : super(PostLogicsInitial()) {
    on<CreatePostEvent>(createPostEvent);
    on<RemovePostEvent>(removePostEvent);
    on<SavePostEvent>(savePostEvent);
    on<UnsavePostEvent>(unsavePostEvent);
  }

  FutureOr<void> createPostEvent(
      CreatePostEvent event, Emitter<PostLogicsState> emit) async {
    emit(CreatePostLoadingState());
    String description = event.description;
    String location = event.location;
    List<String> imageUrlList =
        await CloudRepo.uploadImage(event.selectedAssets);
    String response =
        await PostRepo.createPost(location, description, imageUrlList);
    if (response == 'success' && imageUrlList.isNotEmpty) {
      emit(CreatePostSuccessState(imagePathList: imageUrlList));
    } else {
      emit(CreatePostErrorState());
    }
  }

  FutureOr<void> removePostEvent(
      RemovePostEvent event, Emitter<PostLogicsState> emit) async {
    emit(RemovePostLoadingState());
    String response = await PostRepo.removePost(event.postId);
    if (response == 'success') {
      emit(RemovePostSuccessState());
    } else {
      emit(RemovePostErrorState());
    }
  }

  FutureOr<void> savePostEvent(
      SavePostEvent event, Emitter<PostLogicsState> emit) async {
    String response = await PostRepo.savePost(event.postId);
    if (response == 'success') {
      emit(SavedPostSuccessState());
    }
  }

  FutureOr<void> unsavePostEvent(
      UnsavePostEvent event, Emitter<PostLogicsState> emit) async {
    String response = await PostRepo.unsavePost(event.postId);
    if (response == 'success') {
      emit(UnsavePostSuccessState());
    }
  }
}
