import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CustomSmartRefresher extends StatelessWidget {
  const CustomSmartRefresher({
    super.key,
    required this.child,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    required this.scrollController,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoading;
  final RefreshController refreshController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return KRefreshWidgetConfig(
      child: SmartRefresher(
        controller: refreshController,
        physics: const BouncingScrollPhysics(),
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: onRefresh,
        onLoading: onLoading,
        child: child,
      ),
    );
  }
}

class KRefreshWidgetConfig extends StatelessWidget {
  final Widget child;
  const KRefreshWidgetConfig({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => CustomHeader(
        builder: (context, mode) {
          Widget body = const SizedBox();
          if (mode == RefreshStatus.idle) {
            body = const RefreshHelperWidget(
              icon: CupertinoIcons.refresh,
              text: "Pull down to refresh",
            );
          } else if (mode == RefreshStatus.refreshing) {
            body = const CupertinoActivityIndicator(
              radius: 12,
              color: Colors.black,
            );
          } else if (mode == RefreshStatus.failed) {
            body = const RefreshHelperWidget(
              icon: CupertinoIcons.clear_circled,
              text: "Failed to load data",
            );
          } else if (mode == RefreshStatus.canRefresh) {
            body = const RefreshHelperWidget(
              icon: CupertinoIcons.capslock,
              text: "Release to load",
            );
          } else if (mode == RefreshStatus.completed) {
            body = const RefreshHelperWidget(
              icon: CupertinoIcons.checkmark_alt_circle,
              text: "Load Completed",
            );
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      footerBuilder: () => CustomFooter(
        builder: (context, mode) {
          Widget body = const SizedBox();
          if (mode == LoadStatus.loading) {
            body = const CupertinoActivityIndicator(
              radius: 12,
              color: Colors.black,
            );
          } else if (mode == LoadStatus.failed) {
            body = const RefreshHelperWidget(
              icon: CupertinoIcons.clear_circled,
              text: "Failed to load data",
              isFooter: true,
            );
          } else if (mode == LoadStatus.canLoading) {
            body = const RefreshHelperWidget(
              icon: CupertinoIcons.capslock,
              text: "Release to load",
              isFooter: true,
            );
          } else if (mode == LoadStatus.noMore) {
            body = const RefreshHelperWidget(
              icon: CupertinoIcons.checkmark_alt_circle,
              text: "You have reached the end",
              isFooter: true,
            );
          }
          return SizedBox(
            height: 70.0,
            child: Center(child: body),
          );
        },
      ),
      enableScrollWhenRefreshCompleted: true,
      enableLoadingWhenFailed: true,
      hideFooterWhenNotFull: false,
      child: child,
    );
  }
}

class RefreshHelperWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isFooter;

  const RefreshHelperWidget({
    super.key,
    required this.icon,
    required this.text,
    this.isFooter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isFooter) kHeight(10),
        Icon(
          icon,
          size: 20,
          color: CupertinoColors.systemGrey2,
        ),
        const SizedBox(height: 10),
        Text(
          text,
          style: const TextStyle(
            color: CupertinoColors.systemGrey2,
            height: 1,
            fontSize: 14,
          ),
        ),
        if (!isFooter) kHeight(10),
      ],
    );
  }
}
