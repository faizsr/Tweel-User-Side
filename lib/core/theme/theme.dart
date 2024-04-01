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

void changeSystemThemeOnPopup({Color? color, required BuildContext context}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Theme.of(context).colorScheme.brightness,
      statusBarBrightness: Theme.of(context).colorScheme.brightness,
      systemNavigationBarColor: color ?? const Color(0xFFb8b7bb),
    ),
  );
}

var lightTheme = ThemeData(
  fontFamily: mainFont,
  // brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: lBlack, // Icon || Text Primary Color
    onPrimary: lBlue, // Selected Color
    primaryContainer: lWhite, // Card Color
    onPrimaryContainer: lWhite,
    secondary: lDarkGrey, // Text Color Secondary
    onSecondary: lGrey, // Text Light Color
    outline: lLightGrey, // Divider Color
    outlineVariant: lLightGrey3, // Loading Button & Text Color
    surface: lLightWhite, // Background Color
    onSurface: lLightGrey2, // Loading Skelton Color
    tertiary: lDarkGrey2, // For Remove Dialog Box
    onTertiary: lBottom, // For Bottom Sheet
    surfaceTint: lDialog, // For Dialog Box
    surfaceVariant: lBottom,
    error: Colors.red,
    onError: Colors.red,
    background: Colors.transparent,
    onBackground: Colors.transparent,
  ),
  listTileTheme: const ListTileThemeData(iconColor: lBlack, textColor: lBlack),
  appBarTheme: AppBarTheme(
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
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: dWhite, // Icon || Text Primary Color
    onPrimary: dBlue, // Selected Color
    primaryContainer: dLightBlueGrey, // Card Color
    onPrimaryContainer: lBlack,
    secondary: dLightGrey, // Text Color Secondary
    onSecondary: dDarkGrey, // Text Light Color
    outline: dDarkGrey2, // Divider Color
    outlineVariant: dLightBlueGrey2, // Loading Button & Text Color
    surface: dBlueGrey, // Background Color
    onSurface: dLightBlueGrey2, // Loading Skelton Color
    tertiary: dBlack, // For Remove Dialog Box
    onTertiary: dBottom, // For Bottom Sheet
    surfaceTint: dDialog, // For Dialog box
    surfaceVariant: dBottom2,
    error: Colors.red,
    onError: Colors.red,
    background: Colors.transparent,
    onBackground: Colors.transparent,
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
