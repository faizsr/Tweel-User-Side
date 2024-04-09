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
    var theme = Theme.of(context);
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: Container(
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
          border: Border.all(
            color: theme.colorScheme.outline,
            width: 1,
          ),
        ),
        child: TabBar(
          tabAlignment: TabAlignment.fill,
          controller: tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(5),
          ),
          labelColor: theme.colorScheme.onPrimaryContainer,
          unselectedLabelColor: theme.colorScheme.primary,
          tabs: const [
            TabItem(title: 'POSTS'),
            TabItem(title: 'SAVED'),
          ],
        ),
      ),
    );
  }
}
