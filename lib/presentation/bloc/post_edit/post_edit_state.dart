part of 'post_edit_bloc.dart';

@immutable
sealed class PostEditState {}

final class PostEditInitial extends PostEditState {}

class EditPostLoadingState extends PostEditState {}

class EditPostSuccessState extends PostEditState {}

class EditPostErrorState extends PostEditState {}
