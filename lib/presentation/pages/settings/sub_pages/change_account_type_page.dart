import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile_logics/profile_logics_bloc.dart';
import 'package:tweel_social_media/presentation/pages/settings/widgets/settings_appbar.dart';

class ChangeAccountTypePage extends StatefulWidget {
  const ChangeAccountTypePage({
    super.key,
    required this.accountType,
  });

  final String accountType;

  @override
  State<ChangeAccountTypePage> createState() => _ChangeAccountTypePageState();
}

class _ChangeAccountTypePageState extends State<ChangeAccountTypePage> {
  final List<String> accountTypes = const ['Public', 'Private', 'Business'];
  late String selectedAccounType;

  @override
  void initState() {
    selectedAccounType = widget.accountType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: SettingsAppbar(
          theme: theme,
          title: 'Account type',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: List.generate(
            accountTypes.length,
            (index) => ListTile(
              title: Text(accountTypes[index]),
              onTap: () {
                setState(() {
                  selectedAccounType = accountTypes[index].toLowerCase();
                });
                context.read<ProfileLogicsBloc>().add(
                      ChangeAccountTypeEvent(
                        accountType: accountTypes[index],
                      ),
                    );
              },
              leading: selectedAccounType == accountTypes[index].toLowerCase()
                  ? const Icon(
                      Icons.radio_button_checked,
                      size: 20,
                    )
                  : const Icon(
                      Icons.radio_button_off,
                      size: 20,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
