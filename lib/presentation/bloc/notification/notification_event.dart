part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class FetchAllNotificationEvent extends NotificationEvent {}

class ClearAllNotificationEvent extends NotificationEvent {}