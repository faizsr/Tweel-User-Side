import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/story_model/story_model.dart';
import 'package:tweel_social_media/domain/story_repo/story_repo.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc() : super(StoryInitialState()) {
    on<FetchAllStoriesEvent>(fetchAllStoriesEvent);
    on<AddStoryEvent>(addStoryEvent);
  }

  FutureOr<void> fetchAllStoriesEvent(
      FetchAllStoriesEvent event, Emitter<StoryState> emit) async {
    emit(FetchStoriesLoadingState());
    List<StoryModel> storiesList = await StoryRepo.getAllStories();
    if (storiesList.isNotEmpty) {
      emit(FetchStoriesSuccessState(storiesList: storiesList));
    } else {
      emit(FetchStoriesErrorState());
    }
  }

  FutureOr<void> addStoryEvent(
      AddStoryEvent event, Emitter<StoryState> emit) async {
    emit(AddStoryLoadingState());
    String result = await StoryRepo.addStory(event.userId, event.imageUrl);
    if (result == 'success') {
      emit(AddStorySucessState());
    } else {
      emit(AddStoryErrorState());
    }
  }
}
