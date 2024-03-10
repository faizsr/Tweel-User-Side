import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';

class PostUserDetail extends StatelessWidget {
  const PostUserDetail({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            debugPrint('Go to profile');
          },
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(postModel.user!['profile_picture']),
          ),
          
        ),
        kWidth(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postModel.user!['fullname'],
              style: const TextStyle(fontSize: 15),
            ),
            kHeight(5),
            SizedBox(
              width: 150,
              child: Text(
                postModel.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11, color: kDarkGrey),
              ),
            ),
          ],
        ),
        const Spacer(),
        const Icon(Icons.more_vert_sharp)
      ],
    );
  }
}
