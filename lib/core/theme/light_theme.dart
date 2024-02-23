import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

void mySystemTheme() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

var lightTheme = ThemeData(
  fontFamily: 'Coco-Gothic-Pro',
  scaffoldBackgroundColor: kWhite,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontVariations: fontWeightRegular),
    bodyMedium: TextStyle(fontVariations: fontWeightRegular),
    bodySmall: TextStyle(fontVariations: fontWeightRegular),
    labelSmall: TextStyle(fontVariations: fontWeightRegular),
    labelMedium: TextStyle(fontVariations: fontWeightRegular),
    labelLarge: TextStyle(fontVariations: fontWeightRegular),
    displaySmall: TextStyle(fontVariations: fontWeightRegular),
    displayMedium: TextStyle(fontVariations: fontWeightRegular),
    displayLarge: TextStyle(fontVariations: fontWeightRegular),
    titleSmall: TextStyle(fontVariations: fontWeightRegular),
    titleMedium: TextStyle(fontVariations: fontWeightRegular),
    titleLarge: TextStyle(fontVariations: fontWeightRegular),
  ),
);
