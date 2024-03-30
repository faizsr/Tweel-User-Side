import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

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
          height: 70,
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              kIconbutton(0, Ktweel.home, theme),
              Container(
                height: 20,
                width: 2,
                color: theme.colorScheme.outline,
              ),
              kIconbutton(1, Ktweel.search, theme),
              Container(
                height: 20,
                width: 2,
                color: theme.colorScheme.outline,
              ),
              kIconbutton(2, Ktweel.message, theme),
              Container(
                height: 20,
                width: 2,
                color: theme.colorScheme.outline,
              ),
              kIconbutton(3, Ktweel.user, theme),
            ],
          ),
        );
      },
    );
  }

  IconButton kIconbutton(int index, IconData icon, ThemeData theme) {
    return IconButton(
      enableFeedback: false,
      onPressed: () {
        indexChangeNotifier.value = index;
      },
      icon: indexChangeNotifier.value == index
          ? Icon(
              icon,
              color: theme.colorScheme.onPrimary,
              size: 25,
            )
          : Icon(
              icon,
              color: theme.iconTheme.color,
              size: 25,
            ),
    );
  }
}
