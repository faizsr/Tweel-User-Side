import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/domain/repository/post_repo/post_repo.dart';

part 'post_by_id_event.dart';
part 'post_by_id_state.dart';

class PostByIdBloc extends Bloc<PostByIdEvent, PostByIdState> {
  PostByIdBloc() : super(PostByIdInitial()) {
    on<FetchPostByIdEvent>(fetchPostByIdEvent);
  }

  FutureOr<void> fetchPostByIdEvent(
      FetchPostByIdEvent event, Emitter<PostByIdState> emit) async {
    emit(FetchPostByIdLoadingState());
    PostModel? postModel = await PostRepo.fetchPostsById(event.postId);
    if (postModel != null) {
      emit(FetchPostByIdSuccessState(postModel: postModel));
    } else {
      emit(FetchPostByIdErrorState());
    }
  }
}
