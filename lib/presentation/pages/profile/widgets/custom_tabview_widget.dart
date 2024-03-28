import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/posts_grid_view.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/saved_grid_view.dart';

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
        if (profileState.posts.isNotEmpty)
          PostsGridViewWidget(profileState: profileState)
        else
          const PostEmtpyViewWidget(),
        const SavedGridViewWidget()
      ],
    );
  }
}
