import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 100,
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            boxShadow: kBoxShadow,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: const Text(
            'Hey, how are you?',
            style: TextStyle(color: lWhite),
          ),
        ),
      ),
    );
  }
}
