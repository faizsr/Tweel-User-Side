part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

class FetchAllNotificationLoadingState extends NotificationState {}

class FetchAllNotificationSuccessState extends NotificationState {
  final List<NotificationModel> notifications;

  FetchAllNotificationSuccessState({
    required this.notifications,
  });
}

class FetchAllNotificationErrorState extends NotificationState {}

class ClearAllNotificationSuccessState extends NotificationState {}

class ClearAllNotificationErrorState extends NotificationState {}
