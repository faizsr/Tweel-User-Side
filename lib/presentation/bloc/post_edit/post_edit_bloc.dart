import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/domain/post_repo/post_repo.dart';

part 'post_edit_event.dart';
part 'post_edit_state.dart';

class PostEditBloc extends Bloc<PostEditEvent, PostEditState> {
  PostEditBloc() : super(PostEditInitial()) {
    on<EditPostEvent>(editPostEvent);
  }

  FutureOr<void> editPostEvent(
      EditPostEvent event, Emitter<PostEditState> emit) async {
    emit(EditPostLoadingState());
    String response = await PostRepo.editPost(event.postModel);
    if (response == 'success') {
      emit(EditPostSuccessState());
    } else {
      emit(EditPostErrorState());
    }
  }
}
