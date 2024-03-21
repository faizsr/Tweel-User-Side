import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ExplorePosts extends StatelessWidget {
  const ExplorePosts({super.key});

  @override
  Widget build(BuildContext context) {
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
          itemCount: 32,
          itemBuilder: (context, index) {
            if (index % 2 == 0) {
              return const Tile(height: 220);
            }
            if (index % 3 == 0) {
              return const Tile(height: 150);
            }
            return const Tile(height: 190);
          },
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ],
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.height,
  });

  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}
