part of 'report_bloc.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

class ReportUserLoadingState extends ReportState {}

class ReportUserSuccessState extends ReportState {}

class ReportUserErrorState extends ReportState {}

class ReportPostLoadingState extends ReportState {}

class ReportPostSuccessState extends ReportState {}

class ReportPostErrorState extends ReportState {}