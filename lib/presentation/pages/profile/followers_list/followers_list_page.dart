import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/pages/profile/followers_list/widgets/followers_appbar.dart';
import 'package:tweel_social_media/presentation/pages/profile/followers_list/widgets/followers_view.dart';
import 'package:tweel_social_media/presentation/pages/profile/followers_list/widgets/following_view.dart';

class FollowerListPage extends StatefulWidget {
  const FollowerListPage({
    super.key,
    required this.selectedPage,
  });

  final int selectedPage;

  @override
  State<FollowerListPage> createState() => _FollowerListPageState();
}

class _FollowerListPageState extends State<FollowerListPage> {
  late TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.selectedPage,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: FollowersAppbar(
            searchController: searchController,
          ),
        ),
        body: const TabBarView(
          children: [
            FollowersView(),
            FollowingView(),
          ],
        ),
      ),
    );
  }
}
