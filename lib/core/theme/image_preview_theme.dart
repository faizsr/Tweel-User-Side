import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

var imagePreviewlightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
    color: kWhite,
  ),
  scaffoldBackgroundColor: kWhite,
  canvasColor: kBlack,
  iconTheme: const IconThemeData(color: kBlack),
);
