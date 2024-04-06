// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/notification/notification_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/comment_notify_card.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/follow_notifiy_card.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/like_notify_card.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/notfiy_appbar.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/notification_loading.dart';
import 'package:tweel_social_media/presentation/widgets/refresh_widget.dart';

import '../../../data/models/notification_model/notification_model.dart';

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

  List<NotificationModel> filterNotification(
      List<NotificationModel> notifications) {
    return notifications
        .where((notification) => notification.updatedAt != '')
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  @override
  Widget build(BuildContext context) {
    changeSystemThemeOnPopup(
      color: Theme.of(context).colorScheme.surface,
      context: context,
    );
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
          child: MultiBlocBuilder(
            blocs: [
              context.watch<NotificationBloc>(),
              context.watch<ProfileBloc>(),
            ],
            builder: (context, state) {
              var state1 = state[0];
              var state2 = state[1];
              if (state1 is FetchAllNotificationLoadingState) {
                return const NotificationLoadingWidget();
              }

              if (state1 is FetchAllNotificationSuccessState) {
                if (state2 is ProfileFetchingSucessState) {
                  return ListView.separated(
                    separatorBuilder: (context, index) => kHeight(20),
                    padding: const EdgeInsets.all(15),
                    itemCount: state1.notifications.length,
                    itemBuilder: (context, index) {
                      // ============= Filtered On Newest First =============
                      final filteredNotifications =
                          filterNotification(state1.notifications);
                      final notification = filteredNotifications[index];

                      // ============= Comment Type Is Like =============
                      if (notification.type == 'like') {
                        return LikeNotifyCard(
                          notificationModel: notification,
                          currentUser: state2.userDetails,
                        );
                      }

                      // ============= Comment Type Is Comment =============
                      if (notification.type == 'comment') {
                        return CommentNotifyCard(
                          notificationModel: notification,
                          currentUser: state2.userDetails,
                        );
                      }

                      // ============= Comment Type is Follow =============
                      if (notification.type == 'follow') {
                        return FollowNotifyCard(
                          notificationModel: notification,
                        );
                      }
                      return Container(
                        height: 50,
                        color: lWhite,
                        child: Text(state1.notifications[index].type),
                      );
                    },
                  );
                }
              }
              return const Center(
                child: Text('No new nofications'),
              );
            },
          ),
        ),
      ),
    );
  }
}
