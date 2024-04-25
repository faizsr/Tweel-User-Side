import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/explore_loading.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/grid_tile.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/empty_post_widget.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';

class ExplorePosts extends StatelessWidget {
  const ExplorePosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitialState) {
          context.read<PostBloc>().add(PostInitialFetchEvent());
        }
        if (state is PostDetailFetchingLoadingState) {
          return Column(
            children: [
              _titleWidget(context),
              const ExplorePostLoading(),
            ],
          );
        }
        if (state is PostDetailFetchingSucessState) {
          return Column(
            children: [
              _titleWidget(context),
              _postGridView(state, context),
            ],
          );
        }
        return const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: EmptyPostWidget(),
        );
      },
    );
  }

  StaggeredGridView _postGridView(
      PostDetailFetchingSucessState state, BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
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
            height: size.height * 0.26,
            imageUrl: url,
            onTap: () {
              nextScreen(
                context,
                PostDetailPage(
                  postModel: post,
                  userModel: post.user,
                ),
              ).then((value) => mySystemTheme(context));
            },
          );
        } else if (!isImage) {
          return VideoTile(
            url: url,
            height: size.height * 0.26,
            onTap: () {
              nextScreen(
                context,
                PostDetailPage(
                  postModel: post,
                  userModel: post.user,
                ),
              ).then((value) => mySystemTheme(context));
            },
          );
        }
        if (index % 3 == 0 && isImage) {
          return ImageTile(
            height: size.height * 0.22,
            imageUrl: url,
            onTap: () {
              nextScreen(
                context,
                PostDetailPage(
                  postModel: post,
                  userModel: post.user,
                ),
              ).then((value) => mySystemTheme(context));
            },
          );
        } else if (!isImage) {
          return VideoTile(
            url: url,
            height: size.height * 0.22,
            onTap: () {
              nextScreen(
                context,
                PostDetailPage(
                  postModel: post,
                  userModel: post.user,
                ),
              ).then((value) => mySystemTheme(context));
            },
          );
        }
        if (isImage) {
          return ImageTile(
            height: size.height * 0.24,
            imageUrl: url,
            onTap: () {
              nextScreen(
                context,
                PostDetailPage(
                  postModel: post,
                  userModel: post.user,
                ),
              ).then((value) => mySystemTheme(context));
            },
          );
        } else if (!isImage) {
          return VideoTile(
            url: url,
            height: size.height * 0.24,
            onTap: () {
              nextScreen(
                context,
                PostDetailPage(
                  postModel: post,
                  userModel: post.user,
                ),
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

  Widget _titleWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      child: Stack(
        fit: StackFit.loose,
        children: [
          const Align(
            child: Text(
              'Explore',
              style: TextStyle(fontSize: 22, height: 1.7),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 15,
            child: SizedBox(
              width: 15,
              child: Divider(
                height: 10,
                thickness: 1,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
