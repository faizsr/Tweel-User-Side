import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/search_follower/search_follower_bloc.dart';
import 'package:tweel_social_media/presentation/pages/profile/connection_list/widgets/followers_appbar.dart';
import 'package:tweel_social_media/presentation/pages/profile/connection_list/widgets/followers_view.dart';
import 'package:tweel_social_media/presentation/pages/profile/connection_list/widgets/following_view.dart';

class ConnectionListPage extends StatefulWidget {
  const ConnectionListPage({
    super.key,
    required this.selectedPage,
    required this.followers,
    required this.following,
    this.isCurrentUser = false,
    required this.userId,
  });

  final int selectedPage;
  final List followers;
  final List following;
  final bool isCurrentUser;
  final String userId;

  @override
  State<ConnectionListPage> createState() => ConnectionListPageState();
}

class ConnectionListPageState extends State<ConnectionListPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.selectedPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: FollowersAppbar(
          userId: widget.userId,
          tabController: tabController,
          searchController: searchController,
          onChanged: (value) {
            if (tabController.index == 0) {
              context.read<SearchBloc>().add(SearchFollowerEvent(
                  query: value, followers: widget.followers));
            }
            if (tabController.index == 1) {
              context.read<SearchBloc>().add(SearchFollowingEvent(
                  query: value, following: widget.following));
            }
          },
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          FollowersView(
            followers: widget.followers,
            isCurrentUser: widget.isCurrentUser,
          ),
          FollowingView(
            following: widget.following,
            isCurrentUser: widget.isCurrentUser,
          ),
        ],
      ),
    );
  }
}
