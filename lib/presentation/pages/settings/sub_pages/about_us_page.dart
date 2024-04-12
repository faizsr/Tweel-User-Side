import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/settings/utils/text_styles.dart';
import 'package:tweel_social_media/presentation/pages/settings/utils/utils.dart';
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
        children: [
          _heading(context),
          content(AboutUs.about),
          kHeight(15),
          content(AboutUs.stayTuned),
          kHeight(20),
          _heading2('What Sets Us Apart:'),
          bulletedList(AboutUs.featureTitle, AboutUs.features),
          kHeight(20),
          _heading2('Our Vision:'),
          kHeight(5),
          content(AboutUs.ourVision),
        ],
      ),
    );
  }

  Text _heading2(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontVariations: fontWeightW600,
      ),
    );
  }

  Text _heading(BuildContext context) {
    return Text(
      'Tweel,',
      style: TextStyle(
        fontSize: 24,
        fontVariations: fontWeightW600,
        height: 2,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
