import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/media_picker_page.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class StoryUtils {
  static Widget loadingStoryCard() {
    return Container(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Column(
        children: [
          const CircleAvatar(radius: 30, backgroundColor: kLightGrey),
          kHeight(10),
          const Skelton(width: 50),
        ],
      ),
    );
  }

  static Widget emptyStoryView(BuildContext context, String? userId) {
    return GestureDetector(
      onTap: () {
        nextScreen(
          context,
          MediaPicker(
            maxCount: 1,
            requestType: RequestType.image,
            screenType: ScreenType.story,
            userId: userId,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 5, left: 5),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 0.5, color: Theme.of(context).colorScheme.primary),
              ),
              child: const Icon(Icons.add),
            ),
            kHeight(5),
            const Text(
              'Create Story',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
