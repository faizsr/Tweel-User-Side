import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class FollowersView extends StatelessWidget {
  const FollowersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      shrinkWrap: true,
      itemCount: 30,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(radius: 25),
          title: const Text(
            'William Smith',
            style: TextStyle(
              fontSize: 15,
              fontVariations: fontWeightW500,
              height: 1.5,
            ),
          ),
          minVerticalPadding: 18,
          subtitle: const Text(
            '@williamsam',
            style: TextStyle(
              fontSize: 12,
              color: kGray,
            ),
          ),
          trailing: SizedBox(
            width: 94,
            height: 30,
            child: CustomOutlinedBtn(
              onPressed: () {},
              btnText: 'REMOVE',
            ),
          ),
        );
      },
    );
  }
}
