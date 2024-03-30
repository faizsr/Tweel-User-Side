// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/custom_tabbar_widget.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/custom_tabview_widget.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_page_loading.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/user_detail_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  int count = 5;
  late TabController tabController;

  @override
  void initState() {
    context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
    context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    mySystemTheme(context);
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is UserDetailFetchingLoadingState) {
                return const ProfilePageLoading();
              }
              if (state is UserDetailFetchingSucessState) {
                return ListView(
                  children: [
                    UserDetailsWidget(
                      userModel: state.userDetails,
                      postsList: state.posts,
                    ),
                    kHeight(50),
                    CustomTabBarWiget(tabController: tabController),
                    kHeight(15),
                    CustomTabviewWidget(
                      profileState: state,
                      tabController: tabController,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
