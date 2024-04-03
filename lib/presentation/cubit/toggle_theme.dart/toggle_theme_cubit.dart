import 'package:flutter_bloc/flutter_bloc.dart';


class ToggleThemeCubit extends Cubit<bool> {
  ToggleThemeCubit() : super(false);

  void toggle() {
    emit(!state);
  }
}
