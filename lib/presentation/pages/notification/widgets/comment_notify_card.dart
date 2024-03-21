import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CommentNotifyCard extends StatelessWidget {
  const CommentNotifyCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 50,
                color: kLightGrey,
              ),
              kWidth(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Emma watson commented',
                    style: TextStyle(fontSize: 14),
                  ),
                  kHeight(5),
                  Text(
                    'Greatly appreciated',
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              '1 hour ago',
              style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
          )
        ],
      ),
    );
  }
}
