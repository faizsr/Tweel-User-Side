import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/repository/user_repo/user_repo.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc() : super(SearchUserInitial()) {
    on<SearchUserEvent>(searchUserEvent);
  }

  FutureOr<void> searchUserEvent(
      SearchUserEvent event, Emitter<SearchUserState> emit) async {
    emit(SearchResultLoadingState());
    List<UserModel> users = await UserRepo.searchUsers(event.query,event.onMessage);
    if (users.isNotEmpty) {
      emit(SearchResultSuccessState(users: users));
    } else {
      emit(SearchResultErrorState());
    }
  }
}
