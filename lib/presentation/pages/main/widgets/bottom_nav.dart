import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);
final homePageController = ScrollController();
final explorePageController = ScrollController();
final messagePageController = ScrollController();
final profilePageController = ScrollController();

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ValueListenableBuilder<int>(
      valueListenable: indexChangeNotifier,
      builder: (context, int newIndex, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.08,
          color: theme.colorScheme.primaryContainer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              kIconbutton(
                index: 0,
                icon: Ktweel.home,
                theme: theme,
                onDoubleTap: () {
                  homePageController.animateTo(
                    homePageController.position.minScrollExtent,
                    duration: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  );
                },
              ),
              Container(
                height: 20,
                width: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              kIconbutton(
                index: 1,
                icon: Ktweel.search,
                theme: theme,
                onDoubleTap: () {
                  explorePageController.animateTo(
                    explorePageController.position.minScrollExtent,
                    duration: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  );
                },
              ),
              Container(
                height: 20,
                width: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              kIconbutton(
                index: 2,
                icon: Ktweel.message,
                theme: theme,
                onDoubleTap: () {
                  messagePageController.animateTo(
                    messagePageController.position.minScrollExtent,
                    duration: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  );
                },
              ),
              Container(
                height: 20,
                width: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              kIconbutton(
                index: 3,
                icon: Ktweel.user,
                theme: theme,
                onDoubleTap: () {
                  profilePageController.animateTo(
                    profilePageController.position.minScrollExtent,
                    duration: 400.ms,
                    curve: Curves.fastOutSlowIn,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  IconButton kIconbutton(
      {required int index,
      required IconData icon,
      required ThemeData theme,
      void Function()? onDoubleTap}) {
    return IconButton(
      enableFeedback: false,
      onPressed: () {
        indexChangeNotifier.value = index;
      },
      icon: indexChangeNotifier.value == index
          ? GestureDetector(
              onDoubleTap: onDoubleTap,
              child: Icon(
                icon,
                color: theme.colorScheme.onPrimary,
                size: 25,
              ),
            )
          : Icon(
              icon,
              color: theme.colorScheme.secondary,
              size: 25,
            ),
    );
  }
}
