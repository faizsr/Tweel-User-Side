import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/notification_model/notification_model.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class FollowNotifyCard extends StatelessWidget {
  const FollowNotifyCard({
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
                backgroundImage: notificationModel.user.profilePicture == ""
                    ? Image.asset(profilePlaceholder).image
                    : NetworkImage(notificationModel.user.profilePicture!),
              ),
              kWidth(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${notificationModel.user.fullName} followed you.',
                    style: const TextStyle(fontSize: 14),
                  ),
                  kHeight(10),
                  SizedBox(
                    height: 35,
                    width: 100,
                    child: CustomOutlinedBtn(
                      onPressed: () {},
                      btnText: 'FOLLOW BACK',
                    ),
                  )
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
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
