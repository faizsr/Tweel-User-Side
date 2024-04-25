import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({
    super.key,
    required this.chatUser,
  });

  final UserModel chatUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(chatUser.profilePicture ?? ''),
        ),
        kHeight(15),
        SizedBox(
          height: 40,
          width: 120,
          child: CustomOutlinedBtn(
            onPressed: () {
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surface,
                context: context,
              );
              nextScreen(
                  context,
                  UserProfilePage(
                    userId: chatUser.id ?? '',
                    isCurrentUser: false,
                  )).then((value) => mySystemTheme(context));
            },
            btnText: 'VIEW PROFILE',
          ),
        ),
        kHeight(10),
        const Text(
          'Type your first message!',
          style: TextStyle(
            fontSize: 18,
            fontVariations: fontWeightW700,
          ),
        ),
        kHeight(5),
        Text(
          "It's time to start a chat",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
