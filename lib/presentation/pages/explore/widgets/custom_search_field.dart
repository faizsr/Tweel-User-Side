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
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        kHeight(15),
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: CupertinoSearchTextField(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            backgroundColor: theme.colorScheme.primaryContainer,
            prefixInsets: const EdgeInsetsDirectional.only(start: 10),
            suffixInsets: const EdgeInsetsDirectional.only(end: 10),
            prefixIcon: Icon(
              CustomIcons.search_normal_2,
              color: theme.colorScheme.primary,
              size: 20,
            ),
            suffixIcon: Icon(
              Icons.close,
              color: theme.colorScheme.onSecondary,
            ),
            placeholder: 'Search here...',
            placeholderStyle: TextStyle(
              color: theme.colorScheme.secondary,
              fontSize: 14,
              fontFamily: mainFont,
              fontVariations: fontWeightW500,
              letterSpacing: 0.2,
            ),
            style: TextStyle(
              color: theme.colorScheme.primary,
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
