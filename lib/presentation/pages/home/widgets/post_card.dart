import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/widgets/video_player.dart';

class PostCardWidget extends StatefulWidget {
  const PostCardWidget({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
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
          // Posted User Details
          postedUserDetail(),
          kHeight(15),

          // Post Description
          ReadMoreText(
            widget.postModel.description,
            trimLines: 2,
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'more',
            trimExpandedText: ' less',
            style: const TextStyle(fontSize: 13),
            lessStyle: const TextStyle(fontSize: 13, color: kGray),
            moreStyle: const TextStyle(fontSize: 13, color: kGray),
          ),
          kHeight(15),

          // Post Image Section
          postImage(),
          kHeight(15),

          // Post Action Buttons
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
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(widget.postModel.user.profilePicture!),
        ),
        kWidth(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.postModel.user.fullName!,
              style: const TextStyle(fontSize: 15),
            ),
            kHeight(5),
            SizedBox(
              width: 150,
              child: Text(
                widget.postModel.location,
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

  SizedBox postImage() {
    return SizedBox(
      height: 400,
      child: PageView.builder(
        itemCount: widget.postModel.mediaURL.length,
        itemBuilder: (context, index) {
          return Container(
            child: widget.postModel.mediaURL[index].toString().contains('image')
                ? Image.network(widget.postModel.mediaURL[index],
                    fit: BoxFit.cover)
                : VideoPlayerWidget(videoUrl: widget.postModel.mediaURL[index]),
          );
        },
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
