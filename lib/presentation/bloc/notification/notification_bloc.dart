import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/data/models/notification_model/notification_model.dart';
import 'package:tweel_social_media/domain/notification_repo/notification_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial()) {
    on<FetchAllNotificationEvent>(fetchAllNotifications);
    on<ClearAllNotificationEvent>(clearAllNotificationEvent);
  }

  FutureOr<void> fetchAllNotifications(
      FetchAllNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(FetchAllNotificationLoadingState());
    List<NotificationModel> notifications =
        await NotificationRepo.getAllNotification();
    if (notifications.isNotEmpty) {
      emit(FetchAllNotificationSuccessState(notifications: notifications));
    } else {
      emit(FetchAllNotificationErrorState());
    }
  }

  FutureOr<void> clearAllNotificationEvent(
      ClearAllNotificationEvent event, Emitter<NotificationState> emit) async {
    bool response = await NotificationRepo.clearAllNotification();
    if (response) {
      emit(ClearAllNotificationSuccessState());
    } else {
      emit(ClearAllNotificationErrorState());
    }
  }
}
