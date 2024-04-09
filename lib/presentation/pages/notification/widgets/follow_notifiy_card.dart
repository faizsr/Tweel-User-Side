import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/notification_model/notification_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/follow_btn_widget.dart';

class FollowNotifyCard extends StatelessWidget {
  const FollowNotifyCard({
    super.key,
    required this.notificationModel,
  });

  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    void followUnfollowFunction(
        UserModel currentUserModel, UserModel user, bool? isUnfollowing) {
      if (user.followers!.contains(currentUserModel) || isUnfollowing!) {
        notificationModel.user.followers!.removeWhere(
          (element) => element['_id'] == currentUserModel.id,
        );
      } else {
        notificationModel.user.followers!.add(currentUserModel.toJson());
      }
    }

    return InkWell(
      onTap: () {
        nextScreen(
            context,
            UserProfilePage(
              userId: notificationModel.user.id!,
              isCurrentUser: false,
            )).then(
          (value) => mySystemTheme(context),
        );
        context
            .read<UserByIdBloc>()
            .add(FetchUserByIdEvent(userId: notificationModel.user.id!));
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
                InkWell(
                  onTap: () {
                    debugPrint('Go to profile');
                    nextScreen(
                        context,
                        UserProfilePage(
                          userId: notificationModel.user.id!,
                          isCurrentUser: false,
                        ));
                    context.read<UserByIdBloc>().add(
                        FetchUserByIdEvent(userId: notificationModel.user.id!));
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: theme.colorScheme.onSurface,
                    backgroundImage: notificationModel.user.profilePicture == ""
                        ? Image.asset(profilePlaceholder).image
                        : NetworkImage(notificationModel.user.profilePicture!),
                  ),
                ),
                kWidth(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kHeight(20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 160,
                      child: Text(
                        '${notificationModel.user.fullName} followed you.',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    kHeight(10),
                    SizedBox(
                        height: 35,
                        width: 100,
                        child: FollowButton(
                          userModel: notificationModel.user,
                          onFollowUnfollow: followUnfollowFunction,
                        ))
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
