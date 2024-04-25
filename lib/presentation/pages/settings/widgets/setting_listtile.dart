import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  final IconData leadingIcon;
  final String title;
  final Widget trailing;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      tileColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      leading: Icon(leadingIcon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
