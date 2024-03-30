import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
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
            icon: const Icon(Ktweel.arrow_left_ios),
          ),
          const Text(
            'Notifications',
            style: TextStyle(fontSize: 22),
          ),
          const Spacer(),
          SizedBox(
            height: 35,
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
