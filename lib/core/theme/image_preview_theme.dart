import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';

var imagePreviewlightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
    color: lWhite,
  ),
  scaffoldBackgroundColor: lWhite,
  canvasColor: lBlack,
  iconTheme: const IconThemeData(color: lBlack),
);
