import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/post_grid_image_tile.dart';

class PostGridView extends StatelessWidget {
  const PostGridView({
    super.key,
    required this.state,
  });

  final FetchUserByIdSuccessState state;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
                    color: theme.colorScheme.surface,
                    context: context,
                  );
                  nextScreen(
                    context,
                    PostDetailPage(
                      postModel: state.posts[index],
                      userModel: state.userModel,
                    ),
                  );
                },
                child: PostImageGridTile(
                  imageUrl: state.posts[index].mediaURL![0],
                ),
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
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                ),
                onPressed: () {},
                icon: Icon(
                  Ktweel.grid,
                  size: 35,
                  color: theme.colorScheme.onSecondary,
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
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ],
          );
  }
}
