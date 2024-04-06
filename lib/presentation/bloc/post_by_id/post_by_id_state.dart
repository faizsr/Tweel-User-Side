part of 'post_by_id_bloc.dart';

@immutable
sealed class PostByIdState {}

final class PostByIdInitial extends PostByIdState {}

class FetchPostByIdLoadingState extends PostByIdState {}

class FetchPostByIdSuccessState extends PostByIdState {
  final PostModel postModel;

  FetchPostByIdSuccessState({
    required this.postModel,
  });
}

class FetchPostByIdErrorState extends PostByIdState {}
