import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/cubit/on_search/on_search_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/on_search_message/on_search_cubit.dart';

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
                context: context,
                index: 0,
                icon: Ktweel.home,
                theme: theme,
                onDoubleTap: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    if (homePageController.hasClients) {
                      homePageController.animateTo(
                        homePageController.position.minScrollExtent,
                        duration: 400.ms,
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  });
                },
              ),
              Container(
                height: 20,
                width: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              kIconbutton(
                context: context,
                index: 1,
                icon: Ktweel.search,
                theme: theme,
                onDoubleTap: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    if (explorePageController.hasClients) {
                      explorePageController.animateTo(
                        explorePageController.position.minScrollExtent,
                        duration: 400.ms,
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  });
                },
              ),
              Container(
                height: 20,
                width: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              kIconbutton(
                context: context,
                index: 2,
                icon: Ktweel.message,
                theme: theme,
                onDoubleTap: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    if (messagePageController.hasClients) {
                      messagePageController.animateTo(
                        explorePageController.position.minScrollExtent,
                        duration: 400.ms,
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  });
                },
              ),
              Container(
                height: 20,
                width: 1,
                color: theme.colorScheme.outlineVariant,
              ),
              kIconbutton(
                context: context,
                index: 3,
                icon: Ktweel.user,
                theme: theme,
                onDoubleTap: () {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    if (profilePageController.hasClients) {
                      profilePageController.animateTo(
                        profilePageController.position.minScrollExtent,
                        duration: 400.ms,
                        curve: Curves.fastOutSlowIn,
                      );
                    }
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }

  IconButton kIconbutton({
    required int index,
    required IconData icon,
    required ThemeData theme,
    void Function()? onDoubleTap,
    required BuildContext context,
  }) {
    return IconButton(
      enableFeedback: false,
      onPressed: () {
        indexChangeNotifier.value = index;
        FocusScope.of(context).unfocus();
        context.read<OnSearchMessageCubit>().onSearchChange(false);
        context.read<OnSearchCubit>().onSearchChange(false);
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
