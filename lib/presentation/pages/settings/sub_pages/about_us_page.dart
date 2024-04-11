import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/pages/settings/widgets/settings_appbar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SettingsAppbar(
          theme: theme,
          title: 'About Us',
        ),
      ),
      backgroundColor: theme.colorScheme.surface,
    );
  }
}
