import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RefreshWidget extends StatelessWidget {
  const RefreshWidget({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  final Widget child;
  final Future Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      displacement: 10,
      indicatorBuilder: (context, controller) {
        return SpinKitChasingDots(
          color: Theme.of(context).colorScheme.primary,
          size: 25,
        );
      },
      onRefresh: onRefresh,
      child: child,
    );
  }
}
