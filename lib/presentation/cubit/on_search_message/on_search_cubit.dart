import 'package:flutter_bloc/flutter_bloc.dart';

class OnSearchMessageCubit extends Cubit<bool> {
  OnSearchMessageCubit() : super(false);

  void onSearchChange(bool value) {
    emit(value);
  }
}
