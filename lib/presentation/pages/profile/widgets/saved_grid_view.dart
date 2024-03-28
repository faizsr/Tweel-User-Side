import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/services/video_thumbnail/video_thumbnail_services.dart';
import 'package:tweel_social_media/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';

class SavedGridViewWidget extends StatelessWidget {
  const SavedGridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedPostsBloc, SavedPostsState>(
      builder: (context, state) {
        if (state is FetchAllSavedPostSuccessState) {
          return StaggeredGridView.countBuilder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.savedPosts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  nextScreen(
                    context,
                    PostDetailPage(
                      postModel: state.savedPosts[index],
                      userModel: state.savedPosts[index].user,
                    ),
                  );
                },
                child: savedImageCard(savedPostState: state, index: index),
              );
            },
            staggeredTileBuilder: (index) => StaggeredTile.count(
                (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          );
        }
        return Container();
      },
    );
  }

  Widget savedImageCard({
    required FetchAllSavedPostSuccessState savedPostState,
    required int index,
  }) {
    String url = savedPostState.savedPosts[index].mediaURL![0];
    if (url.contains('image')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      );
    } else if (url.contains('video')) {
      return FutureBuilder(
        future: VideoThumbnailServices.getVideoThumbnail(url),
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
}
