import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';

class ReadMoreWidget extends StatelessWidget {
  const ReadMoreWidget({
    super.key,
    required this.text,
    required this.postModel,
    required this.userModel,
  });

  final String text;
  final PostModel postModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var color = theme.colorScheme.secondary;
    return GestureDetector(
      onTap: () {
        changeSystemThemeOnPopup(
          color: theme.colorScheme.surface,
          context: context,
        );
        nextScreen(
            context,
            PostDetailPage(
              postModel: postModel,
              userModel: userModel,
            )).then((value) => mySystemTheme(context));
      },
      child: ReadMoreText(
        text,
        trimLines: 3,
        textAlign: TextAlign.start,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'more',
        trimExpandedText: ' less',
        style: const TextStyle(fontSize: 13),
        lessStyle: TextStyle(fontSize: 13, color: color),
        moreStyle: TextStyle(fontSize: 13, color: color),
      ),
    );
  }
}
