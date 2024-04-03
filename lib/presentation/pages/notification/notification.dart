// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/notification/notification_bloc.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/comment_notify_card.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/follow_notifiy_card.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/like_notify_card.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/notfiy_appbar.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/notification_loading.dart';
import 'package:tweel_social_media/presentation/widgets/refresh_widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(FetchAllNotificationEvent());
    super.initState();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<NotificationBloc>().add(FetchAllNotificationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: NotifyAppbar(),
        ),
        body: RefreshWidget(
          onRefresh: _handleRefresh,
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is FetchAllNotificationLoadingState) {
                return const NotificationLoadingWidget();
              }
              if (state is FetchAllNotificationSuccessState) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return kHeight(20);
                  },
                  // reverse: true,
                  padding: const EdgeInsets.all(15),
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final filteredNotifications = state.notifications
                        .where((notification) => notification.updatedAt != '')
                        .toList()
                      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

                    final notification = filteredNotifications[index];
                    if (notification.type == 'like') {
                      return LikeNotifyCard(
                        notificationModel: notification,
                      );
                    }
                    if (notification.type == 'comment') {
                      return CommentNotifyCard(
                        notificationModel: notification,
                      );
                    }
                    if (notification.type == 'follow') {
                      return FollowNotifyCard(
                        notificationModel: notification,
                      );
                    }
                    return Container(
                      height: 50,
                      color: lWhite,
                      child: Text(state.notifications[index].type),
                    );
                  },
                );
              }
              return const Center(
                child: Text('No nofications'),
              );
            },
          ),
        ),
      ),
    );
  }
}
