import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/media_picker_page.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/post_grid_image_tile.dart';
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
              color: Theme.of(context).colorScheme.surface,
              context: context,
            );
            nextScreen(
              context,
              PostDetailPage(
                postModel: profileState.posts[index],
                userModel: profileState.userDetails,
              ),
            ).then((value) => mySystemTheme(context));
          },
          child: PostImageGridTile(
            imageUrl: profileState.posts[index].mediaURL![0],
          ),
        );
      },
      staggeredTileBuilder: (index) => StaggeredTile.count(
          (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}

class PostEmtpyViewWidget extends StatelessWidget {
  const PostEmtpyViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        kHeight(70),
        IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                width: 1.5,
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),
          onPressed: () {
            changeSystemThemeOnPopup(
              color: theme.colorScheme.surface,
              context: context,
            );
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
            color: theme.colorScheme.onSecondary,
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
            color: theme.colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
