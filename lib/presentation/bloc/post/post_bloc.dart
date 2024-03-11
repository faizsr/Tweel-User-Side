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
    on<EditPostEvent>(editPostEvent);
    on<RemovePostEvent>(removePostEvent);
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
    debugPrint('description ${event.description}');
    debugPrint('location ${event.location}');
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

  FutureOr<void> editPostEvent(
      EditPostEvent event, Emitter<PostState> emit) async {
    emit(EditPostLoadingState());
    String response = await PostRepo.editPost(event.postModel);
    if (response == 'success') {
      emit(EditPostSuccessState());
    } else {
      emit(EditPostErrorState());
    }
  }

  FutureOr<void> removePostEvent(
      RemovePostEvent event, Emitter<PostState> emit) async {
    emit(RemovePostLoadingState());
    String response = await PostRepo.removePost(event.postId);
    if (response == 'success') {
      debugPrint('Post removed successfully');
      emit(RemovePostSuccessState());
    } else {
      emit(RemovePostErrorState());
    }
  }
}
