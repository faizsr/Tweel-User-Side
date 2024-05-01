import 'package:flutter_bloc/flutter_bloc.dart';

class TogglePasswordCubit extends Cubit<bool> {
  TogglePasswordCubit() : super(true);

  void toggle() {
    emit(!state);
  }

  void reset() {
    emit(true); 
  }
}
