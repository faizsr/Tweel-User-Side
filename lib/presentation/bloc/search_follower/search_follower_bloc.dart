import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_follower_event.dart';
part 'search_follower_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchFollowerInitial()) {
    on<SearchFollowerEvent>(searchFollowerEvent);
    on<SearchFollowingEvent>(searchFollowingEvent);
  }

  FutureOr<void> searchFollowerEvent(
      SearchFollowerEvent event, Emitter<SearchState> emit) {
    emit(SearchFollowerLoadingState());
    List searchedList = [];
    for (var element in event.followers) {
      final String fullname = element['fullname'].toLowerCase();
      final String username = element['username'].toLowerCase();
      final String searchTerm = event.query.toLowerCase();
      if (fullname.contains(searchTerm) || username.contains(searchTerm)) {
        searchedList.add(element);
      }
    }
    emit(SearchFollowerLoadedState(followers: searchedList));
  }

  FutureOr<void> searchFollowingEvent(
      SearchFollowingEvent event, Emitter<SearchState> emit) {
    emit(SearchFollowingLoadingState());
    List searchedList = [];
    for (var element in event.following) {
      final String fullname = element['fullname'].toLowerCase();
      final String username = element['username'].toLowerCase();
      final String searchTerm = event.query.toLowerCase();
      if (fullname.contains(searchTerm) || username.contains(searchTerm)) {
        searchedList.add(element);
      }
    }
    emit(SearchFollowingLoadedState(following: searchedList));
  }
}
