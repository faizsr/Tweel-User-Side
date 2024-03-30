import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';

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
          icon: const Icon(Ktweel.arrow_left),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        shrinkWrap: true,
        children: [
          customListTile(Ktweel.notification, 'Notification',
              Ktweel.arrow_circle_right, context),
          kHeight(15),
          customListTile(
              Ktweel.moon, 'Dark theme', Ktweel.arrow_circle_right, context),
          kHeight(15),
          customListTile(Ktweel.text_file, 'Privacy & policy',
              Ktweel.arrow_circle_right, context),
          kHeight(15),
          customListTile(
            Ktweel.about,
            'About us',
            Ktweel.arrow_circle_right,
            context,
          ),
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
