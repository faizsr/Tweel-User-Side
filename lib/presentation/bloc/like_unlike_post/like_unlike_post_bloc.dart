import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/domain/post_repo/post_repo.dart';

part 'like_unlike_post_event.dart';
part 'like_unlike_post_state.dart';

class LikeUnlikePostBloc
    extends Bloc<LikeUnlikePostEvent, LikeUnlikePostState> {
  LikeUnlikePostBloc() : super(LikeUnlikePostInitial()) {
    on<LikePostEvent>(likePostEvent);
    on<UnlikePostEvent>(unlikePostEvent);
  }

  FutureOr<void> likePostEvent(
      LikePostEvent event, Emitter<LikeUnlikePostState> emit) async {
    String response = await PostRepo.likePost(event.postId);
    if (response == 'success') {
      emit(LikedPostState());
    } else {
      debugPrint('Error in like post');
    }
  }

  FutureOr<void> unlikePostEvent(
      UnlikePostEvent event, Emitter<LikeUnlikePostState> emit) async {
    String response = await PostRepo.unlikePost(event.postId);
    if (response == 'success') {
      emit(UnlikedPostState());
    } else {
      debugPrint('Error in unlike post');
    }
  }
}
