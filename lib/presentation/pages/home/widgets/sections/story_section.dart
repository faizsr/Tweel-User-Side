import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 0, 20),
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            blurRadius: 40,
            color: Colors.black.withOpacity(0.05),
          )
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Row(
              children: [
                const Icon(
                  CustomIcons.refresh,
                  size: 14,
                ),
                kWidth(10),
                const Text(
                  'Stories',
                  style: TextStyle(fontSize: 15),
                ),
                const Spacer(),
                const Icon(
                  CustomIcons.add,
                  size: 25,
                ),
              ],
            ),
          ),
          kHeight(20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
              child: Row(
                children: List.generate(20, (index) => _storyCard()),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _storyCard() {
    return Container(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Column(
        children: [
          const CircleAvatar(radius: 30),
          kHeight(5),
          const SizedBox(
            width: 70,
            child: Text(
              'benjaminjac',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
