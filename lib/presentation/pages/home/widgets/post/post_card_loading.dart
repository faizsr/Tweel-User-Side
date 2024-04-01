import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
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
      padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: kBoxShadow,
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
          const Skelton(height: 380),
          kHeight(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _postActionBtn('0 likes', Ktweel.like),
              Container(height: 15, width: 1, color: Colors.grey.shade300),
              _postActionBtn('0 comments', Ktweel.comment),
              Container(height: 15, width: 1, color: Colors.grey.shade300),
              _postActionBtn('Share', Ktweel.send_2),
            ],
          )
        ],
      ),
    );
  }

  Row postedUserDetail() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Theme.of(context).colorScheme.onSurface,
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
        Icon(
          Ktweel.more_vert,
          color: Theme.of(context).colorScheme.onSurface,
        ),
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
