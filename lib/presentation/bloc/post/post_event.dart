part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class PostInitialFetchEvent extends PostEvent {}

class CreatePostEvent extends PostEvent {
  final PostModel postModel;

  CreatePostEvent({
    required this.postModel,
  });
}

class UploadImageToCloudEvent extends PostEvent {
  final List<AssetEntity> selectedAssets;

  UploadImageToCloudEvent({
    required this.selectedAssets,
  });
}
