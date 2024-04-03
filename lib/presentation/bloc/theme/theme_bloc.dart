import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.system) {
    on<ChangeTheme>(changeTheme);
  }

  FutureOr<void> changeTheme(ChangeTheme event, Emitter<ThemeMode> emit) {
    emit(event.isDark ? ThemeMode.dark : ThemeMode.light);
  }
}
