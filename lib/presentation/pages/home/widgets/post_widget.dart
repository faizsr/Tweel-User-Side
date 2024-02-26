import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Posts',
            style: TextStyle(fontSize: 16),
          ),
          kHeight(10),
          Column(
            children: List.generate(5, (index) => _postCard(index)),
          )
        ],
      ),
    );
  }

  Container _postCard(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            blurRadius: 40,
            color: Colors.black.withOpacity(0.05),
          )
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 20),
              kWidth(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jordan Miller',
                    style: TextStyle(fontSize: 15),
                  ),
                  kHeight(5),
                  const Text(
                    'New York city',
                    style: TextStyle(fontSize: 10, color: kDarkGrey),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_vert_sharp)
            ],
          ),
          kHeight(15),
          const ReadMoreText(
            "Inspired by a biography of Coco Channel and trying to capture the quientessiontial mood. Flutter is Google's mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.",
            trimLines: 2,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'more',
            trimExpandedText: ' less',
            style: TextStyle(fontSize: 13),
            lessStyle: TextStyle(fontSize: 13, color: kGray),
            moreStyle: TextStyle(fontSize: 13, color: kGray),
          ),
          if (index != 2) kHeight(15),
          if (index != 2)
            Container(
              height: 300,
              color: Colors.grey.shade200,
            ),
          kHeight(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _postActionBtn('Like', CustomIcons.like),
              Container(height: 15, width: 1, color: Colors.grey.shade300),
              _postActionBtn('Comment', CustomIcons.messages_2),
              Container(height: 15, width: 1, color: Colors.grey.shade300),
              _postActionBtn('Share', CustomIcons.send_2),
            ],
          )
        ],
      ),
    );
  }

  Row _postActionBtn(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20),
        kWidth(5),
        Text(title),
      ],
    );
  }
}
