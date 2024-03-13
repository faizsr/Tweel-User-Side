import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class ReadMoreWidget extends StatelessWidget {
  const ReadMoreWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: 3,
      textAlign: TextAlign.start,
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: 'more',
      trimExpandedText: ' less',
      style: const TextStyle(fontSize: 13),
      lessStyle: const TextStyle(fontSize: 13, color: kGray),
      moreStyle: const TextStyle(fontSize: 13, color: kGray),
    );
  }
}
