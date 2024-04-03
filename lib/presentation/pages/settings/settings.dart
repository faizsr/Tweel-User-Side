import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/theme/theme_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/toggle_notify_cubit/toggle_notify_cubit.dart';
import 'package:tweel_social_media/presentation/cubit/toggle_theme.dart/toggle_theme_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Settings'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Ktweel.arrow_left),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          shrinkWrap: true,
          children: [
            customListTile(
              Ktweel.notification,
              'Notification',
              BlocBuilder<ToggleNotifyCubit, bool>(
                builder: (context, state) {
                  return Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: state,
                      onChanged: (value) {
                        context.read<ToggleNotifyCubit>().toggle();
                      },
                    ),
                  );
                },
              ),
              context,
            ),
            kHeight(15),
            customListTile(
              Ktweel.moon,
              'Dark theme',
              BlocBuilder<ToggleThemeCubit, bool>(
                builder: (context, state) {
                  return Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: !state,
                      onChanged: (value) {
                        context.read<ToggleThemeCubit>().toggle();
                        if (!state) {
                          changeSystemThemeOnPopup(
                            color: lLightWhite,
                            context: context,
                          );
                          context
                              .read<ThemeBloc>()
                              .add(ChangeTheme(isDark: state));
                        } else {
                          changeSystemThemeOnPopup(
                            color: dBlueGrey,
                            context: context,
                          );
                          context
                              .read<ThemeBloc>()
                              .add(ChangeTheme(isDark: state));
                        }
                      },
                    ),
                  );
                },
              ),
              context,
            ),
            kHeight(15),
            customListTile(
              Ktweel.text_file,
              'Privacy & policy',
              const Icon(Ktweel.arrow_circle_right),
              context,
            ),
            kHeight(15),
            customListTile(
              Ktweel.about,
              'About us',
              const Icon(Ktweel.arrow_circle_right),
              context,
            ),
          ],
        ),
      ),
    );
  }

  ListTile customListTile(IconData leadingIcon, String title, Widget trailing,
      BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      tileColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(leadingIcon),
      title: Text(title),
      trailing: trailing,
    );
  }
}
