import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/repository/post_repo/post_repo.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<AddCommentEvent>(addCommentEvent);
    on<DeleteCommentEvent>(deleteCommentEvent);
  }

  FutureOr<void> addCommentEvent(
      AddCommentEvent event, Emitter<CommentState> emit) async {
    String response = await PostRepo.addComment(event.comment, event.postId);
    if (response == 'success') {
      event.postModel.comments!.add(
        CommentModel(
          user: event.userModel,
          comment: event.comment,
          createdDate: DateTime.now().toString(),
        ),
      );
      emit(CommentAddedState());
    }
  }

  FutureOr<void> deleteCommentEvent(
      DeleteCommentEvent event, Emitter<CommentState> emit) async {
    String response =
        await PostRepo.deleteComment(event.commentId, event.postId);
    if (response == 'success') {
      event.postModel.comments!
          .removeWhere((element) => element.id == event.commentId);
      emit(CommentDeletedState());
    }
  }
}
