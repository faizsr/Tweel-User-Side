import 'dart:ui';

import 'package:flutter/material.dart';

const kWhite = Colors.white;
const kLightWhite = Color(0xFFF5F6FA);
const kGray = Color(0xFF8F8F8F);
const kDarkGrey = Color(0xFF4B4B4B);
const kBlack = Colors.black;
const kDarkBlue = Color(0xFF3E23A9);

const fontWeightRegular = <FontVariation>[FontVariation('wght', 400.0)];
const fontWeightW700 = <FontVariation>[FontVariation('wght', 700.0)];
const fontWeightW600 = <FontVariation>[FontVariation('wght', 600.0)];

SizedBox kHeight(double? height) => SizedBox(height: height);
SizedBox kWidth(double? width) => SizedBox(width: width);



nextScreen(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}
