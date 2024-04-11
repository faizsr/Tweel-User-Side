import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/pages/settings/widgets/settings_appbar.dart';

class PrivacyAndPolicyPage extends StatelessWidget {
  const PrivacyAndPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SettingsAppbar(
          theme: theme,
          title: 'Privacy & Policy',
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: const [
          Text(
            'This privacy policy applies to the Tweel application for mobile devices that was created by Faiz S R as a Free service. This service is intended for use "AS IS".',
          ),
          Text('Information Collection and Use'),
          Text(
            'The Application collects information when you download and use it. This information may include information such as',
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("• "),
              Expanded(
                child: Text("The time spent on the Application"),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("• "),
              Expanded(
                child:
                    Text("The operating system you use on your mobile device"),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("• "),
              Expanded(
                child: Text(
                    "Your device's Internet Protocol address (e.g. IP address)"),
              ),
            ],
          ),
          Text(
            "The Application does not gather precise information about the location of your mobile device.",
          ),
          Text(
            "The Service Provider may use the information you provided to contact you from time to time to provide you with important information, required notices and marketing promotions.",
          ),
          Text(
            'For a better experience, while using the Application, the Service Provider may require you to provide us with certain personally identifiable information, including but not limited to Name, phone number, email, profile picture. The information that the Service Provider request will be retained by them and used as described in this privacy policy.',
          )
        ],
      ),
    );
  }
}
