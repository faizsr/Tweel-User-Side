import 'package:flutter_bloc/flutter_bloc.dart';

class OnSearchCubit extends Cubit<bool> {
  OnSearchCubit() : super(false);

  void onSearchChange(bool value) {
    emit(value);
  }
}
