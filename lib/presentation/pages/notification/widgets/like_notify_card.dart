import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/data/models/notification_model/notification_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/post_detail_notify.dart';

import '../../../../core/utils/constants.dart';

class LikeNotifyCard extends StatelessWidget {
  const LikeNotifyCard({
    super.key,
    required this.notificationModel,
    required this.currentUser,
  });

  final NotificationModel notificationModel;
  final UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: () {
        nextScreen(
          context,
          PostDetailNotify(
            postId: notificationModel.post!.id!,
            currentUser: currentUser,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                      image: NetworkImage(notificationModel.post!.mediaURL![0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                kWidth(15),
                Column(
                  children: [
                    kHeight(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Text(
                        '${notificationModel.user.fullName} liked your post.',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
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
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
