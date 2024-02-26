import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: indexChangeNotifier,
        builder: (context, int newIndex, _) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            color: kWhite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                kIconbutton(0, CustomIcons.home),
                Container(
                  height: 20,
                  width: 2,
                  color: Colors.grey.shade300,
                ),
                kIconbutton(1, CustomIcons.search_normal),
                Container(
                  height: 20,
                  width: 2,
                  color: Colors.grey.shade300,
                ),
                kIconbutton(2, CustomIcons.message_off),
                Container(
                  height: 20,
                  width: 2,
                  color: Colors.grey.shade300,
                ),
                kIconbutton(3, CustomIcons.user),
              ],
            ),
          );
        });
  }

  IconButton kIconbutton(int index, IconData icon) {
    return IconButton(
      enableFeedback: false,
      onPressed: () {
        indexChangeNotifier.value = index;
      },
      icon: indexChangeNotifier.value == index
          ? Icon(
              icon,
              color: kDarkBlue,
              size: 25,
            )
          : Icon(
              icon,
              color: kBlack,
              size: 25,
            ),
    );
  }
}
