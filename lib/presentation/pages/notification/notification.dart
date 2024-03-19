import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/comment_notify_card.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/like_notify_card.dart';
import 'package:tweel_social_media/presentation/pages/notification/widgets/notfiy_appbar.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: kLightWhite,
      child: Scaffold(
        backgroundColor: kLightWhite,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: NotifyAppbar(),
        ),
        body: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const LikeNotifyCard(),
            kHeight(20),
            const CommentNotifyCard(),
            kHeight(20),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(10),
                // boxShadow: kBoxShadow,
              ),
              child: Stack(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(radius: 25),
                      kWidth(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jordan miller followed you.',
                            style: TextStyle(fontSize: 14),
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
                  const Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      'Yesterday',
                      style: TextStyle(fontSize: 11, color: kGray),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
