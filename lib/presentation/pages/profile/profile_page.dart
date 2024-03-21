import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:tweel_social_media/core/theme/light_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/custom_tabbar_widget.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/custom_tabview_widget.dart';
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
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mySystemTheme(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: MultiBlocBuilder(
          blocs: [context.watch<PostBloc>(), context.watch<ProfileBloc>()],
          builder: (context, state) {
            var postState = state[0];
            var profileState = state[1];
            if (postState is RemovePostSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
              context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
            }
            if (profileState is UserDetailFetchingLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (profileState is UserDetailFetchingSucessState) {
              return ListView(
                children: [
                  UserDetailsWidget(
                    userModel: profileState.userDetails,
                    postsList: profileState.posts,
                  ),
                  kHeight(50),
                  CustomTabBarWiget(tabController: tabController),
                  kHeight(15),
                  CustomTabviewWidget(
                    profileState: profileState,
                    tabController: tabController,
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
