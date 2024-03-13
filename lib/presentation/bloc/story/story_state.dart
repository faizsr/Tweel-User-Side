part of 'story_bloc.dart';

@immutable
sealed class StoryState {}

final class StoryInitialState extends StoryState {}

class FetchStoriesLoadingState extends StoryState {}

class FetchStoriesSuccessState extends StoryState {
  final List<StoryModel> storiesList;

  FetchStoriesSuccessState({
    required this.storiesList,
  });
}

class FetchStoriesErrorState extends StoryState {}

class AddStoryLoadingState extends StoryState {}

class AddStorySucessState extends StoryState {}

class AddStoryErrorState extends StoryState {}
