import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/services/video_thumbnail/video_thumbnail_services.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/media_picker_page.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostsGridViewWidget extends StatelessWidget {
  const PostsGridViewWidget({
    super.key,
    required this.profileState,
  });

  final ProfileFetchingSucessState profileState;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: profileState.posts.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surface,context: context,);
            nextScreen(
              context,
              PostDetailPage(
                postModel: profileState.posts[index],
                userModel: profileState.userDetails,
              ),
            ).then((value) => mySystemTheme(context));
          },
          child: postImageCard(index: index),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.count(
          (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }

  Widget postImageCard({
    required int index,
  }) {
    String url = profileState.posts[index].mediaURL![0];
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

class PostEmtpyViewWidget extends StatelessWidget {
  const PostEmtpyViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight(70),
        IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                width: 1.5,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          onPressed: () {
            changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surface,context: context,);
            nextScreen(
              context,
              const MediaPicker(
                maxCount: 10,
                requestType: RequestType.common,
                screenType: ScreenType.post,
              ),
            ).then((value) => mySystemTheme(context));
          },
          icon: Icon(
            Ktweel.add,
            size: 40,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        kHeight(10),
        const Text(
          "You haven't posts yet!",
          style: TextStyle(
            fontSize: 18,
            fontVariations: fontWeightW600,
          ),
        ),
        kHeight(5),
        Text(
          'Share your thoughts and experiences \nwith the community!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
