import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';

class CustomTabviewWidget extends StatelessWidget {
  const CustomTabviewWidget({
    super.key,
    required this.profileState,
    required this.tabController,
  });

  final UserDetailFetchingSucessState profileState;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AutoScaleTabBarView(
      controller: tabController,
      children: [
        StaggeredGridView.countBuilder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profileState.posts.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                nextScreen(
                  context,
                  PostDetailPage(
                    postModel: profileState.posts[index],
                    userModel: profileState.userDetails,
                  ),
                );
              },
              child: postImageCard(profileState, index),
            );
          },
          staggeredTileBuilder: (index) => StaggeredTile.count(
              (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        StaggeredGridView.countBuilder(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: profileState.posts.length,
          itemBuilder: (context, index) => postImageCard(profileState, index),
          staggeredTileBuilder: (index) => StaggeredTile.count(
              (index % 7 == 3) ? 2 : 1, (index % 7 == 3) ? 2 : 1),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ],
    );
  }

  Widget postImageCard(UserDetailFetchingSucessState state, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        state.posts[index].mediaURL![0],
        fit: BoxFit.cover,
      ),
    );
  }
}
