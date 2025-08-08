import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void updateTheme(ThemeMode theme) => emit(theme);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    log('From Theme From Json ${json['theme']}');
    return ThemeMode.values[json['theme']];
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'theme': state.index};
  }
}
