import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/domain/repository/user_repo/user_repo.dart';

part 'user_by_id_event.dart';
part 'user_by_id_state.dart';

class UserByIdBloc extends Bloc<UserByIdEvent, UserByIdState> {
  UserByIdBloc() : super(UserByIdInitial()) {
    on<FetchUserByIdEvent>(fetchUserByIdEvent);
  }

  FutureOr<void> fetchUserByIdEvent(
      FetchUserByIdEvent event, Emitter<UserByIdState> emit) async {
    emit(FetchUserByIdLoadingState());
    UserDetailsModel? userDetail =
        await UserRepo.fetchUserDetailsById(event.userId);
    if (userDetail != null) {
      emit(FetchUserByIdSuccessState(
          userModel: userDetail.user, posts: userDetail.posts));
    } else {
      emit(FetchUserByIdErrorState());
    }
  }
}
