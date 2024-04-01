import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/services/video_thumbnail/video_thumbnail_services.dart';
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
    return state.posts.isNotEmpty
        ? StaggeredGridView.countBuilder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  changeSystemThemeOnPopup(
                      color: Theme.of(context).colorScheme.surface,context: context,);
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
          )
        : Column(
            children: [
              kHeight(80),
              IconButton(
                padding: const EdgeInsets.all(10),
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      width: 1.5,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
                onPressed: () {},
                icon: Icon(
                  Ktweel.grid,
                  size: 35,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              kHeight(10),
              const Text(
                "No posts yet!",
                style: TextStyle(
                  fontSize: 18,
                  fontVariations: fontWeightW600,
                ),
              ),
              kHeight(5),
              Text(
                "This user hasn't shared anything \nwith the community!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ],
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
        future: VideoThumbnailServices.getVideoThumbnail(
            state.posts[index].mediaURL![0]),
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
