part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class PostInitialFetchEvent extends PostEvent {}

class CreatePostEvent extends PostEvent {
  final String location;
  final String description;
  final List<AssetEntity> selectedAssets;

  CreatePostEvent({
    required this.location,
    required this.description,
    required this.selectedAssets,
  });
}

class EditPostEvent extends PostEvent {
  final PostModel postModel;

  EditPostEvent({
    required this.postModel,
  });
}

class RemovePostEvent extends PostEvent {
  final String postId;

  RemovePostEvent({
    required this.postId,
  });
}
