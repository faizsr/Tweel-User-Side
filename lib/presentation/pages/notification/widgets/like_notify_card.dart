import 'package:flutter/material.dart';
import 'package:tweel_social_media/data/models/notification_model/notification_model.dart';

import '../../../../core/utils/constants.dart';

class LikeNotifyCard extends StatelessWidget {
  const LikeNotifyCard({
    super.key,
    required this.notificationModel,
  });

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                backgroundImage:
                    NetworkImage(notificationModel.user.profilePicture!),
              ),
              kWidth(10),
              Text(
                '${notificationModel.user.fullName} liked your post.',
                style: const TextStyle(fontSize: 14),
              ),
              const Spacer(),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              timeAgo(DateTime.parse(notificationModel.updatedAt)),
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
