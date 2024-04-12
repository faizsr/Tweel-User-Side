import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class LoadingFollowBtn extends StatelessWidget {
  const LoadingFollowBtn({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 35,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: theme.colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Text(
          'FOLLOW',
          style: TextStyle(
            fontSize: 10,
            fontVariations: fontWeightW800,
            color: theme.colorScheme.outlineVariant,
          ),
        ),
      ),
    );
  }
}
