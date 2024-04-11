import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/pages/settings/widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.accountType});

  final String accountType;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ColorfulSafeArea(
      color: theme.colorScheme.surface,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
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
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              shrinkWrap: true,
              children: [
                SettingsWidgets.changeThemeTile(context),
                kHeight(15),
                SettingsWidgets.changeAccountTypeTile(context, accountType),
                kHeight(15),
                SettingsWidgets.privacyPolicyTile(context),
                kHeight(15),
                SettingsWidgets.aboutUsListTile(context),
                kHeight(15),
                SettingsWidgets.logoutTile(context),
              ],
            ),
            SettingsWidgets.appVersion(context)
          ],
        ),
      ),
    );
  }
}
