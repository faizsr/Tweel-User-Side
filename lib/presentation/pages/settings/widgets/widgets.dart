// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/data/services/socket/socket_services.dart';
import 'package:tweel_social_media/presentation/pages/settings/sub_pages/about_us_page.dart';
import 'package:tweel_social_media/presentation/pages/settings/sub_pages/change_account_type_page.dart';
import 'package:tweel_social_media/presentation/pages/settings/sub_pages/privacy_and_policy_page.dart';
import 'package:tweel_social_media/presentation/pages/settings/sub_pages/terms_conditions_page.dart';
import 'package:tweel_social_media/presentation/pages/settings/sub_pages/theme_page.dart';
import 'package:tweel_social_media/presentation/pages/settings/widgets/setting_listtile.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';

class SettingsWidgets {
  static Positioned appVersion(BuildContext context) {
    return Positioned(
      bottom: 50,
      child: Center(
        child: Text(
          'v 1.0.0',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }

  static SettingListTile aboutUsListTile(context) {
    return SettingListTile(
      leadingIcon: Ktweel.about,
      title: 'About us',
      trailing: const Icon(Ktweel.arrow_circle_right),
      onTap: () {
        nextScreen(context, const AboutUsPage());
      },
    );
  }

  static SettingListTile privacyPolicyTile(context) {
    return SettingListTile(
      leadingIcon: Ktweel.text_file,
      title: 'Privacy & policy',
      trailing: const Icon(Ktweel.arrow_circle_right),
      onTap: () {
        nextScreen(context, const PrivacyAndPolicyPage());
      },
    );
  }

  static SettingListTile termsConditionsTile(context) {
    return SettingListTile(
      leadingIcon: Ktweel.text_file,
      title: 'Terms & Conditions',
      trailing: const Icon(Ktweel.arrow_circle_right),
      onTap: () {
        nextScreen(context, const TermsAndConditionsPage());
      },
    );
  }

  static SettingListTile changeThemeTile(BuildContext context) {
    return SettingListTile(
      leadingIcon: Ktweel.moon,
      title: 'Change theme',
      trailing: const Icon(Ktweel.arrow_circle_right),
      onTap: () {
        nextScreen(context, const ThemeSwitchPage());
      },
    );
  }

  static SettingListTile changeAccountTypeTile(
    BuildContext context,
    String accountType,
  ) {
    return SettingListTile(
      leadingIcon: Ktweel.user_edit,
      title: 'Change account type',
      trailing: const Icon(Ktweel.arrow_circle_right),
      onTap: () {
        nextScreen(context, ChangeAccountTypePage(accountType: accountType));
      },
    );
  }

  static SettingListTile logoutTile(BuildContext context) {
    return SettingListTile(
      leadingIcon: Ktweel.logout_2,
      title: 'Logout',
      trailing: const SizedBox(),
      onTap: () async {
        changeSystemThemeOnPopup(
          context: context,
        );
        showDialog(
          context: context,
          builder: (context) => CustomAlertDialog(
            title: 'Comeback Soon!',
            description: 'Are you sure, you want \nto logout',
            popBtnText: 'Cancel',
            actionBtnTxt: 'Logout',
            onTap: () async {
              UserAuthStatus.saveUserStatus(false);
              SocketServices().disconnectSocket();
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surface,
                context: context,
              );
              await nextScreenRemoveUntil(
                context,
                const UserSignInPage(),
              );
              mySystemTheme(context);
            },
          ),
        ).then((value) => changeSystemThemeOnPopup(
              context: context,
              color: Theme.of(context).colorScheme.surface,
            ));
      },
    );
  }
}
