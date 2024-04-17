// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile_logics/profile_logics_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/saved_posts/saved_posts_bloc.dart';
import 'package:tweel_social_media/presentation/pages/main/widgets/bottom_nav.dart';
import 'package:tweel_social_media/presentation/widgets/refresh_widget.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/custom_tabbar_widget.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/custom_tabview_widget.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_page_loading.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_detail_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    context.read<SavedPostsBloc>().add(FetchAllSavedPostEvent());
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    mySystemTheme(context);
    return BlocListener<ProfileLogicsBloc, ProfileLogicsState>(
      listener: (context, state) {
        if (state is ChangeAccountTypeSuccessState) {
          _handleRefresh();
        }
      },
      child: ColorfulSafeArea(
        color: theme.colorScheme.surface,
        child: Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: RefreshWidget(
            onRefresh: _handleRefresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              controller: profilePageController,
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileFetchingLoadingState) {
                      return const ProfilePageLoading();
                    }
                    if (state is ProfileFetchingSucessState) {
                      return ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          ProfileDetailsWidget(
                            userModel: state.userDetails,
                            postsList: state.posts,
                            onProfile: true,
                            isCurrentUser: false,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
