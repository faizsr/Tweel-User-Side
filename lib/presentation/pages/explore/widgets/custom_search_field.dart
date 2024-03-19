import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/light_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight(15),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CupertinoSearchTextField(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            backgroundColor: kWhite,
            prefixInsets: const EdgeInsetsDirectional.only(start: 10),
            suffixInsets: const EdgeInsetsDirectional.only(end: 10),
            prefixIcon: const Icon(
              CustomIcons.search_normal_2,
              color: kBlack,
              size: 20,
            ),
            suffixIcon: const Icon(
              Icons.close,
              color: Color(0xFF737373),
            ),
            placeholder: 'Search here...',
            placeholderStyle: TextStyle(
              color: kGray,
              fontSize: 14,
              fontFamily: mainFont,
              fontVariations: fontWeightW500,
              letterSpacing: 0.2,
            ),
            style: TextStyle(
              color: kBlack,
              fontSize: 14,
              fontFamily: mainFont,
              fontVariations: fontWeightW500,
              letterSpacing: 0.2,
            ),
          ),
        ),
        kHeight(15),
      ],
    );
  }
}
