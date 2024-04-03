import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.searchController,
    required this.onChanged,
  });

  final TextEditingController searchController;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        kHeight(15),
        CupertinoSearchTextField(
          controller: searchController,
          onChanged: onChanged,
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          backgroundColor: theme.colorScheme.primaryContainer,
          prefixInsets: const EdgeInsetsDirectional.only(start: 10),
          suffixInsets: const EdgeInsetsDirectional.only(end: 10),
          prefixIcon: Icon(
            Ktweel.search_2,
            color: theme.colorScheme.primary,
            size: 20,
          ),
          suffixIcon: Icon(
            Ktweel.close,
            size: 24,
            color: theme.colorScheme.secondary,
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
        kHeight(15),
      ],
    );
  }
}
