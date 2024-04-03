import 'package:flutter_bloc/flutter_bloc.dart';


class ToggleNotifyCubit extends Cubit<bool> {
  ToggleNotifyCubit() : super(false);

  void toggle() {
    emit(!state);
  }
}
