import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class NotifyAppbar extends StatelessWidget {
  const NotifyAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CustomIcons.arrow_left_2, color: kBlack),
          ),
          const Text(
            'Notifications',
            style: TextStyle(fontSize: 22),
          ),
          const Spacer(),
          SizedBox(
            height: 35,
            width: 100,
            child: CustomOutlinedBtn(
              onPressed: () {},
              btnText: 'MARK AS READ',
            ),
          )
        ],
      ),
    );
  }
}
