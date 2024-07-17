// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

var mainFont = 'Coco-Gothic-Pro';

void mySystemTheme(BuildContext context) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).colorScheme.brightness,
      statusBarBrightness: Theme.of(context).colorScheme.brightness,
      systemNavigationBarColor: Theme.of(context).colorScheme.primaryContainer,
    ),
  );
}

void changeSystemThemeOnPopup(
    {Color? color, required BuildContext context, Color? statusColor}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusColor ?? Colors.transparent,
      statusBarIconBrightness: Theme.of(context).colorScheme.brightness,
      statusBarBrightness: Theme.of(context).colorScheme.brightness,
      systemNavigationBarColor: color ?? const Color(0xFFb8b7bb),
    ),
  );
}

var lightTheme = ThemeData(
  useMaterial3: false,
  fontFamily: mainFont,
  unselectedWidgetColor: lGray,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: lBlack, // Icon || Text Primary Color
    onPrimary: lBlue, // Selected Color
    primaryContainer: lWhite, // Card Color
    onPrimaryContainer: lWhite, // Button Color
    secondary: lGray, // Text Color Secondary
    onSecondary: lLightGrey, // Text Light Color
    outline: lLightGrey2, // Divider Color
    outlineVariant: lLightGrey3, // Loading Button & Text Color
    surface: lLightWhite, // Background Color
    onSurface: lLightGrey4, // Loading Skelton Color
    tertiary: lDialog, // For Remove Dialog On Detail
    onTertiary: lDialog2, // For Remove Dialog On Home
    background: lBottom, // For Bottom Sheet On Detail
    onBackground: lBottom2, // For Bottom Sheet On Home
    surfaceVariant: lPDialog, // For Profile More
    surfaceTint: lPDialog2, // For User Profile More
    scrim: lLightGrey,
    error: Colors.red,
    onError: Colors.red,
  ),
  listTileTheme: const ListTileThemeData(iconColor: lBlack, textColor: lBlack),
  appBarTheme: AppBarTheme(
    // forceMaterialTransparency: true,
    surfaceTintColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: lBlack,
      fontFamily: mainFont,
      fontSize: 20,
      fontVariations: fontWeightRegular,
    ),
    iconTheme: const IconThemeData(color: lBlack),
  ),
  iconTheme: const IconThemeData(color: lBlack),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    bodyMedium: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    bodySmall: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    labelSmall: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    labelMedium: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    labelLarge: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    displaySmall: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    displayMedium: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    displayLarge: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    titleSmall: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    titleMedium: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    titleLarge: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    headlineSmall: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    headlineMedium: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
    headlineLarge: TextStyle(fontVariations: fontWeightRegular, color: lBlack),
  ),
);

var darkTheme = ThemeData(
  fontFamily: mainFont,
  unselectedWidgetColor: dGray,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  splashFactory: NoSplash.splashFactory,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: dWhite, // Icon || Text Primary Color
    onPrimary: dBlue, // Selected Color
    primaryContainer: dDarkGrey, // Card Color
    onPrimaryContainer: dBlack, // Button Color
    secondary: dGray, // Text Color Secondary
    onSecondary: dLightGrey, // Text Light Color
    outline: dLightGrey2, // Divider Color
    outlineVariant: dLightGrey3, // Loading Button & Text Color
    surface: dBlack, // Background Color
    onSurface: dLightBlueGrey2, // Loading Skelton Color
    tertiary: dDialog, // For Remove Dialog On Detail
    onTertiary: dDialog, // For Remove Dialog On Home
    background: dBottom, // For Bottom Sheet On Detail
    onBackground: dBottom2, // For Bottom Sheet On Home
    surfaceVariant: dPDialog, // For Profile More
    surfaceTint: dPDialog, // For User Profile More
    scrim: dLightGrey,
    error: Colors.red,
    onError: Colors.red,
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: dWhite,
      fontFamily: mainFont,
      fontSize: 20,
      fontVariations: fontWeightRegular,
    ),
    iconTheme: const IconThemeData(color: dWhite),
  ),
  listTileTheme: const ListTileThemeData(iconColor: dWhite, textColor: dWhite),
  dividerColor: kLightGrey2,
  iconTheme: const IconThemeData(color: dWhite),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    bodyMedium: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    bodySmall: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    labelSmall: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    labelMedium: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    labelLarge: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    displaySmall: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    displayMedium: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    displayLarge: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    titleSmall: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    titleMedium: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    titleLarge: TextStyle(fontVariations: fontWeightRegular, color: dWhite),
    headlineLarge: TextStyle(
      fontVariations: fontWeightRegular,
      color: dWhite,
      fontSize: 24,
    ),
  ),
);
