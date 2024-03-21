import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: lBlack, // Icon || Text Primary Color
  onPrimary: lBlue, // Selected Color
  primaryContainer: lWhite, // Card Color
  secondary: lDarkGrey, // Text Color Secondary
  onSecondary: lGrey, // Text Light Color
  outline: lLightGrey, // Divider Color
  surface: lLightWhite, // Background Color
  error: Colors.red,
  onError: Colors.red,
  background: Colors.transparent,
  onBackground: Colors.transparent,
  onSurface: Colors.transparent,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: dWhite, // Icon || Text Primary Color
  onPrimary: dBlue, // Selected Color
  primaryContainer: dLightBlueGrey, // Card Color
  secondary: dLightGrey, // Text Color Secondary
  onSecondary: dDarkGrey, // Text Light Color
  outline: dDarkGrey2, // Divider Color
  surface: dBlueGrey, // Background Color
  error: Colors.red,
  onError: Colors.red,
  background: Colors.transparent,
  onBackground: Colors.transparent,
  onSurface: Colors.transparent,
);
