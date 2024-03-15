import 'package:flutter_bloc/flutter_bloc.dart';

enum DropdownState { public, private, business }

class DropdownCubit extends Cubit<DropdownState> {
  DropdownCubit() : super(DropdownState.public);

  void selectOption(DropdownState option) {
    emit(option);
  }
}
