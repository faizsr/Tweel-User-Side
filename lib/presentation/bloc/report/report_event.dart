part of 'report_bloc.dart';

@immutable
sealed class ReportEvent {}

class ReportUserEvent extends ReportEvent {
  final String userId;
  final String description;

  ReportUserEvent({
    required this.userId,
    required this.description,
  });
}

class ReportPostEvent extends ReportEvent {
  final String postId;
  final String description;

  ReportPostEvent({
    required this.postId,
    required this.description,
  });
}
