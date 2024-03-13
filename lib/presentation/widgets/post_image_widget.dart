import 'package:flutter/material.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/widgets/video_player.dart';

class PostImageWidget extends StatelessWidget {
  const PostImageWidget({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint('Image preview');
      },
      child: SizedBox(
        height: 400,
        child: PageView.builder(
          itemCount: postModel.mediaURL!.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: postModel.mediaURL![index].toString().contains('image')
                  ? Image.network(postModel.mediaURL![index], fit: BoxFit.cover)
                  : VideoPlayerWidget(videoUrl: postModel.mediaURL![index]),
            );
          },
        ),
      ),
    );
  }
}
