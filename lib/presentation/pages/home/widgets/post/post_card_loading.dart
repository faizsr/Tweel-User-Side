import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';
import 'package:tweel_social_media/presentation/widgets/shimmer_animate.dart';

class PostCardLoading extends StatefulWidget {
  const PostCardLoading({
    super.key,
  });

  @override
  State<PostCardLoading> createState() => _PostCardLoadingState();
}

class _PostCardLoadingState extends State<PostCardLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.fromLTRB(18, 15, 18, 15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          boxShadow: kBoxShadow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ShimmerAnimate(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              postedUserDetail(theme),
              kHeight(15),
              const Skelton(width: double.infinity),
              kHeight(10),
              const Skelton(width: double.infinity),
              kHeight(10),
              const Skelton(width: 250),
              kHeight(15),
              Skelton(height: MediaQuery.of(context).size.height / 2.2),
              kHeight(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _postActionBtn('0 likes', Ktweel.like, theme),
                  Container(
                      height: 15, width: 1, color: theme.colorScheme.onSurface),
                  _postActionBtn('0 comments', Ktweel.comment, theme),
                  Container(
                      height: 15, width: 1, color: theme.colorScheme.onSurface),
                  _postActionBtn('Share', Ktweel.send_2, theme),
                ],
              )
            ],
          ),
        ));
  }

  Row postedUserDetail(ThemeData theme) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: theme.colorScheme.onSurface,
        ),
        kWidth(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Skelton(width: 130),
            kHeight(8),
            const Skelton(width: 80),
          ],
        ),
        const Spacer(),
        Icon(
          Ktweel.more_vert,
          color: theme.colorScheme.onSurface,
        ),
      ],
    );
  }

  Row _postActionBtn(String title, IconData icon, ThemeData theme) {
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.outlineVariant),
        kWidth(5),
        Text(
          title,
          style: TextStyle(color: theme.colorScheme.outlineVariant),
        ),
      ],
    );
  }
}
