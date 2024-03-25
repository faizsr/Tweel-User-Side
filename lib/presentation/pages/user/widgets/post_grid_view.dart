import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';

class PostGridView extends StatelessWidget {
  const PostGridView({
    super.key,
    required this.state,
  });

  final FetchUserByIdSuccessState state;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            nextScreen(
              context,
              PostDetailPage(
                postModel: state.posts[index],
                userModel: state.userModel,
              ),
            );
          },
          child: postImageCard(state, index),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.count(
          (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }

  Widget postImageCard(FetchUserByIdSuccessState state, int index) {
    if (state.posts[index].mediaURL![0].toString().contains('image')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          state.posts[index].mediaURL![0],
          fit: BoxFit.cover,
        ),
      );
    } else if (state.posts[index].mediaURL![0].toString().contains('video')) {
      return FutureBuilder(
        future: getVideoThumbnail(state.posts[index].mediaURL![0]),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(snapshot.data!.path),
                fit: BoxFit.cover,
              ),
            );
          }
          return Container();
        },
      );
    }

    return Container();
  }

  Future<XFile?> getVideoThumbnail(String videoUrl) async {
    try {
      final fileName = await VideoThumbnail.thumbnailFile(
        video: videoUrl,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.WEBP,
        maxHeight: 64,
        quality: 75,
      );
      debugPrint(fileName.path);
      return fileName;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
