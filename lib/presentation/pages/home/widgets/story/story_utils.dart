import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/media_picker_page.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
import 'package:tweel_social_media/presentation/widgets/shimmer_animate.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class StoryUtils {
  static Widget loadingStoryCard(BuildContext context) {
    return ShimmerAnimate(
      child: Container(
        padding: const EdgeInsets.only(right: 5, left: 5),
        child: Column(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).colorScheme.onSurface),
            kHeight(10),
            const Skelton(width: 50),
          ],
        ),
      ),
    );
  }

  static Widget emptyStoryView(BuildContext context, String? userId) {
    return GestureDetector(
      onTap: () {
        changeSystemThemeOnPopup(
          color: Theme.of(context).colorScheme.surface,
          context: context,
        );
        nextScreen(
          context,
          MediaPicker(
            maxCount: 1,
            requestType: RequestType.image,
            screenType: ScreenType.story,
            userId: userId,
          ),
        ).then((value) => mySystemTheme(context));
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
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.outline),
              ),
              child: const Icon(Ktweel.add),
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
