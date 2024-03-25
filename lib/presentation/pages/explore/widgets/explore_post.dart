import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';

class ExplorePosts extends StatefulWidget {
  const ExplorePosts({super.key});

  @override
  State<ExplorePosts> createState() => _ExplorePostsState();
}

class _ExplorePostsState extends State<ExplorePosts> {
  @override
  void initState() {
    context.read<PostBloc>().add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostDetailFetchingLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PostDetailFetchingSucessState) {
          return Column(
            children: [
              const Center(
                child: Text(
                  'Explore',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              StaggeredGridView.countBuilder(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0 &&
                      state.posts[index].mediaURL![0]
                          .toString()
                          .contains('image')) {
                    return Tile(
                      height: 220,
                      imageUrl: state.posts[index].mediaURL![0],
                    );
                  }
                  if (index % 3 == 0 &&
                      state.posts[index].mediaURL![0]
                          .toString()
                          .contains('image')) {
                    return Tile(
                      height: 150,
                      imageUrl: state.posts[index].mediaURL![0],
                    );
                  }
                  if (state.posts[index].mediaURL![0]
                      .toString()
                      .contains('image')) {
                    return Tile(
                      height: 190,
                      imageUrl: state.posts[index].mediaURL![0]
                              .toString()
                              .contains('image')
                          ? state.posts[index].mediaURL![0]
                          : '',
                    );
                  }
                  return Container();
                },
                staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
            ],
          );
        }
        return const Center(
          child: Text('No data'),
        );
      },
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.height,
    required this.imageUrl,
  });

  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
