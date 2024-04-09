import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  const TabItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
