import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/explore_loading.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/grid_tile.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';

class ExplorePosts extends StatelessWidget {
  const ExplorePosts({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitialState) {
          context.read<PostBloc>().add(PostInitialFetchEvent());
        }
        if (state is PostDetailFetchingLoadingState) {
          return Column(
            children: [
              _titleWidget(),
              const ExplorePostLoading(),
            ],
          );
        }
        if (state is PostDetailFetchingSucessState) {
          return Column(
            children: [
              _titleWidget(),
              _postGridView(state, isDarkMode),
            ],
          );
        }
        return const Center(
          child: Text('No data'),
        );
      },
    );
  }

  StaggeredGridView _postGridView(
      PostDetailFetchingSucessState state, bool isDarkMode) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        PostModel post = state.posts[index];
        final isImage =
            state.posts[index].mediaURL![0].toString().contains('image');
        final url = state.posts[index].mediaURL![0];
        if (index % 2 == 0 && isImage) {
          return ImageTile(
            height: 220,
            imageUrl: url,
            onTap: () {
              changeSystemThemeOnPopup(
                  color: isDarkMode ? dBlueGrey : lLightWhite);
              nextScreen(
                context,
                PostDetailPage(postModel: post, userModel: post.user),
              ).then((value) => mySystemTheme(context));
            },
          );
        } else if (!isImage) {
          return VideoTile(
            url: url,
            height: 220,
            onTap: () {
              changeSystemThemeOnPopup(
                  color: isDarkMode ? dBlueGrey : lLightWhite);
              nextScreen(
                context,
                PostDetailPage(postModel: post, userModel: post.user),
              ).then((value) => mySystemTheme(context));
            },
          );
        }
        if (index % 3 == 0 && isImage) {
          return ImageTile(
            height: 150,
            imageUrl: url,
            onTap: () {
              changeSystemThemeOnPopup(
                  color: isDarkMode ? dBlueGrey : lLightWhite);
              nextScreen(
                context,
                PostDetailPage(postModel: post, userModel: post.user),
              ).then((value) => mySystemTheme(context));
            },
          );
        } else if (!isImage) {
          return VideoTile(
            url: url,
            height: 150,
            onTap: () {
              changeSystemThemeOnPopup(
                  color: isDarkMode ? dBlueGrey : lLightWhite);
              nextScreen(
                context,
                PostDetailPage(postModel: post, userModel: post.user),
              ).then((value) => mySystemTheme(context));
            },
          );
        }
        if (isImage) {
          return ImageTile(
            height: 190,
            imageUrl: url,
            onTap: () {
              changeSystemThemeOnPopup(
                  color: isDarkMode ? dBlueGrey : lLightWhite);
              nextScreen(
                context,
                PostDetailPage(postModel: post, userModel: post.user),
              ).then((value) => mySystemTheme(context));
            },
          );
        } else if (!isImage) {
          return VideoTile(
            url: url,
            height: 190,
            onTap: () {
              changeSystemThemeOnPopup(
                  color: isDarkMode ? dBlueGrey : lLightWhite);
              nextScreen(
                context,
                PostDetailPage(postModel: post, userModel: post.user),
              ).then((value) => mySystemTheme(context));
            },
          );
        }
        return Container();
      },
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }

  Widget _titleWidget() {
    return const Center(
      child: Text(
        'Explore',
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
