import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/cubit/toggle_notify_cubit/toggle_notify_cubit.dart';
import 'package:tweel_social_media/presentation/pages/settings/sub_pages/change_account_type_page.dart';
import 'package:tweel_social_media/presentation/pages/settings/widgets/setting_listtile.dart';
import 'package:tweel_social_media/presentation/pages/settings/sub_pages/theme_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.accountType});

  final String accountType;

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
            notificationTile(),
            kHeight(15),
            changeThemeTile(context),
            kHeight(15),
            changeAccountTypeTile(context),
            kHeight(15),
            privacyPolicyTile(),
            kHeight(15),
            aboutUsListTile(),
          ],
        ),
      ),
    );
  }

  SettingListTile aboutUsListTile() {
    return SettingListTile(
      leadingIcon: Ktweel.about,
      title: 'About us',
      trailing: const Icon(Ktweel.arrow_circle_right),
      onTap: () {},
    );
  }

  SettingListTile privacyPolicyTile() {
    return SettingListTile(
      leadingIcon: Ktweel.text_file,
      title: 'Privacy & policy',
      trailing: const Icon(Ktweel.arrow_circle_right),
      onTap: () {},
    );
  }

  SettingListTile changeThemeTile(BuildContext context) {
    return SettingListTile(
      leadingIcon: Ktweel.moon,
      title: 'Change theme',
      trailing: const Icon(Ktweel.arrow_circle_right),
      onTap: () {
        nextScreen(context, const ThemeSwitchPage());
      },
    );
  }

  SettingListTile changeAccountTypeTile(BuildContext context) {
    return SettingListTile(
      leadingIcon: Ktweel.user_edit,
      title: 'Change account type',
      trailing: const Icon(Ktweel.arrow_circle_right),
      onTap: () {
        nextScreen(context, ChangeAccountTypePage(accountType: accountType));
      },
    );
  }

  SettingListTile notificationTile() {
    return SettingListTile(
      leadingIcon: Ktweel.notification,
      title: 'Notification',
      trailing: BlocBuilder<ToggleNotifyCubit, bool>(
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
      onTap: () {},
    );
  }
}
