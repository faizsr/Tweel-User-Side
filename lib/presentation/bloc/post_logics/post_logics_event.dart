part of 'post_logics_bloc.dart';

@immutable
sealed class PostLogicsEvent {}

class CreatePostEvent extends PostLogicsEvent {
  final String location;
  final String description;
  final List<AssetEntity> selectedAssets;

  CreatePostEvent({
    required this.location,
    required this.description,
    required this.selectedAssets,
  });
}

class RemovePostEvent extends PostLogicsEvent {
  final String postId;

  RemovePostEvent({
    required this.postId,
  });
}

class SavePostEvent extends PostLogicsEvent {
  final String postId;

  SavePostEvent({
    required this.postId,
  });
}

class UnsavePostEvent extends PostLogicsEvent {
  final String postId;

  UnsavePostEvent({
    required this.postId,
  });
}
