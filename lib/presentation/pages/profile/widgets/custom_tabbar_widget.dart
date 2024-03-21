import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/tab_item.dart';

class CustomTabBarWiget extends StatelessWidget {
  const CustomTabBarWiget({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Container(
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).colorScheme.primaryContainer,
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 0.5),
        ),
        child: TabBar(
          tabAlignment: TabAlignment.fill,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          labelColor: Theme.of(context).colorScheme.onPrimaryContainer,
          unselectedLabelColor: Theme.of(context).colorScheme.primary,
          tabs: const [
            TabItem(title: 'POSTS'),
            TabItem(title: 'SAVED'),
          ],
        ),
      ),
    );
  }
}
