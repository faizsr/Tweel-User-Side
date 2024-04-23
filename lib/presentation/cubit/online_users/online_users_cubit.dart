import 'package:flutter_bloc/flutter_bloc.dart';

class OnlineUsersCubit extends Cubit<List<String>> {
  OnlineUsersCubit() : super([]);

  void getOnlineUsers(String username) {
    state.add(username);
    emit(state);
  }
}
