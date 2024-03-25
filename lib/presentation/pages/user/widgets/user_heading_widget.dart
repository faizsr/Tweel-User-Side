import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class UserHeadingWidget extends StatelessWidget {
  const UserHeadingWidget({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.transparent,
            child: Icon(
              CustomIcons.arrow_left_2,
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
          onTap: () {},
          child: const Icon(CustomIcons.settings),
        ),
      ],
    );
  }
}
