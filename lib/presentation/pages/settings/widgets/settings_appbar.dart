import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';

class SettingsAppbar extends StatelessWidget {
  const SettingsAppbar({
    super.key,
    required this.theme,
    required this.title,
  });

  final ThemeData theme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18),
      ),
      titleSpacing: 2,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Ktweel.arrow_left,
          size: 24,
        ),
      ),
    );
  }
}
