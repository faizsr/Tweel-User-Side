import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_menu.dart';

class UserHeadingWidget extends StatelessWidget {
  const UserHeadingWidget({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 15, 0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Colors.transparent,
              child: Icon(
                Ktweel.arrow_left_ios,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          kWidth(10),
          Text(
            userModel.username!,
            style: const TextStyle(fontVariations: fontWeightW700),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surfaceTint,context: context,
              );
              showDialog(
                context: context,
                builder: (context) {
                  return ProfileMenu(
                    leading: const [Ktweel.send, Ktweel.danger, Ktweel.close],
                    profileImage: userModel.profilePicture!,
                    buttonLabel: const [
                      "Sent Message",
                      "Report Account",
                      "Cancel"
                    ],
                    ontap: [
                      () {},
                      () {},
                      () {
                        Navigator.pop(context);
                      },
                    ],
                  );
                },
              ).then((value) => mySystemTheme(context));
            },
            child: const Icon(Ktweel.settings_2),
          ),
        ],
      ),
    );
  }
}
