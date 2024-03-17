part of 'story_bloc.dart';

@immutable
sealed class StoryEvent {}

class FetchAllStoriesEvent extends StoryEvent {}

class AddStoryEvent extends StoryEvent {
  final String userId;
  final List<AssetEntity> selectedAssets;

  AddStoryEvent({
    required this.userId,
    required this.selectedAssets,
  });
}
