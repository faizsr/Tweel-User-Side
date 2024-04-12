import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

Widget bulletedList(List<String> highlightedText, List<String> texts) {
  return ListView(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    children: List.generate(
      texts.length,
      (index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("• "),
          Expanded(
            child: highlightedText.isNotEmpty
                ? buildSpanText(highlightedText[index], texts[index])
                : Text(texts[index]),
          )
        ],
      ),
    ),
  );
}

Text buildSpanText(String highlightedText, String text) {
  return Text.rich(
    TextSpan(
      style: const TextStyle(height: 1.5),
      children: [
        TextSpan(
          text: highlightedText,
          style: const TextStyle(fontVariations: fontWeightW600),
        ),
        TextSpan(text: text),
      ],
    ),
  );
}

Text buildSpanText2(String highlightedText, String text) {
  return Text.rich(
    TextSpan(
      style: const TextStyle(height: 1.5),
      children: [
        TextSpan(text: text),
        TextSpan(
          text: highlightedText,
          style: const TextStyle(fontVariations: fontWeightW600),
        ),
      ],
    ),
  );
}

Text content(String text) {
  return Text(
    text,
    style: const TextStyle(fontSize: 14),
  );
}

Text heading(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      height: 2,
      fontVariations: fontWeightW700,
    ),
  );
}
