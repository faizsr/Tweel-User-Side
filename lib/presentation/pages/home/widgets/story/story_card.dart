import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/story_model/story_model.dart';
import 'package:tweel_social_media/presentation/widgets/fadein_animate.dart';
import 'package:tweel_social_media/presentation/widgets/profile_circle_widget.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.storyModel,
  });

  final StoryModel storyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Column(
        children: [
          ProfileCircleWidget(
            radius: 60,
            imageWidget: storyModel.user['profile_picture'] == ""
                ? Image.asset(profilePlaceholder)
                : FadedImageLoading(
                    imageUrl: storyModel.user['profile_picture'],
                  ),
          ),
          kHeight(5),
          SizedBox(
            width: 70,
            child: Text(
              storyModel.user['username'].toString().toLowerCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
