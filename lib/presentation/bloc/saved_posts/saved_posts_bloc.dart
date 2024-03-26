import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/saved_post_model/saved_post_model.dart';
import 'package:tweel_social_media/domain/post_repo/post_repo.dart';

part 'saved_posts_event.dart';
part 'saved_posts_state.dart';

class SavedPostsBloc extends Bloc<SavedPostsEvent, SavedPostsState> {
  SavedPostsBloc() : super(SavedPostsInitial()) {
    on<FetchAllSavedPostEvent>(fetchSavedPostEvent);
  }

  FutureOr<void> fetchSavedPostEvent(
      FetchAllSavedPostEvent event, Emitter<SavedPostsState> emit) async {
    // emit(FetchAllSavedPostLoadingState());
    List<SavedPostModel> savedPosts = await PostRepo.fetchAllSavedPost();
    print(savedPosts.length);
    if (savedPosts.isNotEmpty) {
      debugPrint('Saved Posts Length: ${savedPosts.length}');
      emit(FetchAllSavedPostSuccessState(savedPosts: savedPosts));
    } else {
      emit(FetchAllSavedPostLoadingState());
    }
  }
}
