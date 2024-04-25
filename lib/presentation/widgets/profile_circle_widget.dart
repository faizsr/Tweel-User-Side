import 'package:flutter/material.dart';

class ProfileCircleWidget extends StatelessWidget {
  const ProfileCircleWidget({
    super.key,
    required this.radius,
    required this.imageWidget,
  });
  final double radius;
  final Widget imageWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: imageWidget,
      ),
    );
  }
}
