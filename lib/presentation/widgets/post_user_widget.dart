import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/widgets/post_more_widget.dart';

class PostUserDetail extends StatelessWidget {
  const PostUserDetail({
    super.key,
    required this.postModel,
    this.userModel,
  });

  final PostModel postModel;
  final UserModel? userModel;

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
            backgroundImage: NetworkImage(postModel.user!['profile_picture'] ??
                userModel!.profilePicture),
          ),
        ),
        kWidth(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postModel.user!['fullname'] ?? userModel!.fullName,
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
        GestureDetector(
          onTap: () {
            PostMoreWidget.bottomSheet(
              context: context,
              postModel: postModel,
              userId: userModel!.id!,
              postId: userModel!.id!,
            );
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Icon(Icons.more_vert_sharp),
          ),
        ),
      ],
    );
  }
}
