import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/presentation/pages/explore/explore_page.dart';
import 'package:tweel_social_media/presentation/pages/home/home_page.dart';
import 'package:tweel_social_media/presentation/pages/main/widgets/bottom_nav.dart';
import 'package:tweel_social_media/presentation/pages/message/message_page.dart';
import 'package:tweel_social_media/presentation/pages/profile/profile_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final _pages = [
    const HomePage(),
    const ExplorePage(),
    const MessagePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    mySystemTheme(context);
    return PopScope(
      canPop: indexChangeNotifier.value != 0,
      onPopInvoked: (didPop) {
        indexChangeNotifier.value = 0;
        return;
      },
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, int index, child) {
            return IndexedStack(
              index: index,
              children: _pages,
            );
          },
        ),
        bottomNavigationBar: const BottomNavigationWidget(),
      ),
    );
  }
}
