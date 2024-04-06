import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/domain/repository/post_repo/post_repo.dart';

part 'saved_posts_event.dart';
part 'saved_posts_state.dart';

class SavedPostsBloc extends Bloc<SavedPostsEvent, SavedPostsState> {
  List<PostModel> savedPostList = [];
  SavedPostsBloc() : super(SavedPostsInitial()) {
    on<FetchAllSavedPostEvent>(fetchSavedPostEvent);
  }

  FutureOr<void> fetchSavedPostEvent(
      FetchAllSavedPostEvent event, Emitter<SavedPostsState> emit) async {
    List<PostModel> savedPosts = await PostRepo.fetchAllSavedPost();
    if (savedPosts.isNotEmpty) {
      savedPostList.addAll(savedPosts);
      emit(FetchAllSavedPostSuccessState(savedPosts: savedPosts));
    } else {
      emit(FetchAllSavedPostErrorState());
    }
  }
}
