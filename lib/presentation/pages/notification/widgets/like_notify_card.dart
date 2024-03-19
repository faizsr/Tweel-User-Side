import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class LikeNotifyCard extends StatelessWidget {
  const LikeNotifyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              const CircleAvatar(
                radius: 25,
              ),
              kWidth(10),
              const Text(
                'Alex zack liked your post.',
                style: TextStyle(fontSize: 14),
              ),
              const Spacer(),
            ],
          ),
          const Align(
            alignment: Alignment.topRight,
            child: Text(
              '2 min ago',
              style: TextStyle(fontSize: 11, color: kGray),
            ),
          )
        ],
      ),
    );
  }
}
