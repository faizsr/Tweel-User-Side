import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class UserHeadingWidget extends StatelessWidget {
  const UserHeadingWidget({
    super.key,
    required this.userModel,
    required this.onProfile,
    required this.isCurrentUser,
    required this.onTap,
  });

  final UserModel userModel;
  final bool onProfile;
  final bool isCurrentUser;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 15, 0),
      child: Row(
        children: [
          onProfile
              ? const SizedBox()
              : InkWell(
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
            userModel.username!.toLowerCase(),
            style: const TextStyle(fontVariations: fontWeightW700),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: isCurrentUser
                ? const SizedBox()
                : onProfile
                    ? const Icon(Ktweel.settings)
                    : const Icon(Ktweel.settings_2),
          ),
        ],
      ),
    );
  }
}
