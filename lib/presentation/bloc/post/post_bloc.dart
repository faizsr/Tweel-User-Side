import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/domain/cloud_repo/cloud_repo.dart';
import 'package:tweel_social_media/domain/post_repo/post_repo.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitialState()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<CreatePostEvent>(createPostEvent);
    on<UploadImageToCloudEvent>(uploadImageToCloudEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostDetailFetchingLoadingState());
    List<PostModel> posts = await PostRepo.fetchAllPosts();
    if (posts.isNotEmpty) {
      emit(PostDetailFetchingSucessState(posts: posts));
    } else {
      emit(PostDetailFetchingErrorState());
    }
  }

  FutureOr<void> createPostEvent(
      CreatePostEvent event, Emitter<PostState> emit) async {
    emit(CreatePostLoadingState());
    String response = await PostRepo.createPost(event.postModel);
    if (response == 'success') {
      emit(CreatePostSuccessState());
    } else {
      emit(CreatePostErrorState());
    }
  }

  FutureOr<void> uploadImageToCloudEvent(
      UploadImageToCloudEvent event, Emitter<PostState> emit) async {
    emit(CreatePostLoadingState());
    List<String> imageUrlList =
        await CloudRepo.uploadImage(event.selectedAssets);
    if (imageUrlList.isNotEmpty) {
      emit(UploadImageSuccessState(imagePathList: imageUrlList));
    } else {
      emit(UploadImageErrorState());
    }
  }
}
