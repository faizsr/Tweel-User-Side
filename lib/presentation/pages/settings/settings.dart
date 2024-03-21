import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Settings'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CustomIcons.arrow_left),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        shrinkWrap: true,
        children: [
          customListTile(CustomIcons.notification_off_bing, 'Notification',
              Icons.arrow_circle_right_outlined, context),
          kHeight(15),
          customListTile(CustomIcons.moon, 'Dark theme',
              Icons.arrow_circle_right_outlined, context),
          kHeight(15),
          customListTile(CustomIcons.note_text, 'Privacy & policy',
              Icons.arrow_circle_right_outlined, context),
          kHeight(15),
          customListTile(CustomIcons.warning_2, 'About us',
              Icons.arrow_circle_right_outlined, context),
        ],
      ),
    );
  }

  ListTile customListTile(IconData leadingIcon, String title,
      IconData trailingIcon, BuildContext context) {
    return ListTile(
      tileColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(leadingIcon),
      title: Text(title),
      trailing: Icon(trailingIcon),
    );
  }
}
