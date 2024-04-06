import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/story_model/story_model.dart';
import 'package:tweel_social_media/domain/repository/cloud_repo/cloud_repo.dart';
import 'package:tweel_social_media/domain/repository/story_repo/story_repo.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
    List<String> imageUrlList =
        await CloudRepo.uploadImage(event.selectedAssets);
    String result = await StoryRepo.addStory(event.userId, imageUrlList[0]);
    if (result == 'success') {
      emit(AddStorySucessState());
    } else {
      emit(AddStoryErrorState());
    }
  }
}
