import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';

class PostCardLoading extends StatefulWidget {
  const PostCardLoading({
    super.key,
  });

  @override
  State<PostCardLoading> createState() => _PostCardLoadingState();
}

class _PostCardLoadingState extends State<PostCardLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          postedUserDetail(),
          kHeight(15),
          const Skelton(width: double.infinity),
          kHeight(10),
          const Skelton(width: double.infinity),
          kHeight(10),
          const Skelton(width: 250),
          kHeight(15),
          const Skelton(height: 400),
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

  Row postedUserDetail() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: kLightGrey,
        ),
        kWidth(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Skelton(width: 130),
            kHeight(8),
            const Skelton(width: 80),
          ],
        ),
        const Spacer(),
        const Icon(Icons.more_vert_sharp)
      ],
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
