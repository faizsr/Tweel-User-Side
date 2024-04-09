import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class PostButton extends StatelessWidget {
  const PostButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              thickness: 0.5,
              color: theme.colorScheme.outline,
            ),
          ),
        ),
        // Container(height: 0.5, color: lBlack, width: double.infinity),
        const Text(
          'POSTS',
          style: TextStyle(fontSize: 12, fontVariations: fontWeightW500),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              thickness: 0.5,
              color: theme.colorScheme.outline,
            ),
          ),
        )
      ],
    );
  }
}
