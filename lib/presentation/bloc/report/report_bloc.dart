import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/domain/post_repo/post_repo.dart';
import 'package:tweel_social_media/domain/user_repo/user_repo.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(ReportInitial()) {
    on<ReportPostEvent>(reportPostEvent);
    on<ReportUserEvent>(reportUserEvent);
  }

  FutureOr<void> reportPostEvent(
      ReportPostEvent event, Emitter<ReportState> emit) async {
    emit(ReportPostLoadingState());
    String response =
        await PostRepo.reportPost(event.postId, event.description);
    if (response == 'success') {
      emit(ReportPostSuccessState());
    } else {
      emit(ReportPostErrorState());
    }
  }

  FutureOr<void> reportUserEvent(
      ReportUserEvent event, Emitter<ReportState> emit) async {
    emit(ReportUserLoadingState());
    String response =
        await UserRepo.reportUser(event.userId, event.description);
    if (response == 'success') {
      emit(ReportUserSuccessState());
    } else {
      emit(ReportUserErrorState());
    }
  }
}
