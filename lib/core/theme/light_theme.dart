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
    bodyLarge: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    bodyMedium: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    bodySmall: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    labelSmall: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    labelMedium: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    labelLarge: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    displaySmall: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    displayMedium: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    displayLarge: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    titleSmall: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    titleMedium: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
    titleLarge: TextStyle(fontVariations: fontWeightRegular, color: kBlack),
  ),
);
