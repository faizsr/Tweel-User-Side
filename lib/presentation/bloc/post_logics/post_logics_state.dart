part of 'post_logics_bloc.dart';

@immutable
sealed class PostLogicsState {}

final class PostLogicsInitial extends PostLogicsState {}

class CreatePostLoadingState extends PostLogicsState {}

class CreatePostSuccessState extends PostLogicsState {
  final List<String> imagePathList;

  CreatePostSuccessState({
    required this.imagePathList,
  });
}

class CreatePostErrorState extends PostLogicsState {}

class RemovePostLoadingState extends PostLogicsState {}

class RemovePostSuccessState extends PostLogicsState {}

class RemovePostErrorState extends PostLogicsState {}

class SavedPostSuccessState extends PostLogicsState {}

class UnsavePostSuccessState extends PostLogicsState {}
