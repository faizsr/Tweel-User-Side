import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tweel_social_media/data/services/video_thumbnail/video_thumbnail_services.dart';
import 'package:tweel_social_media/presentation/widgets/fadein_animate.dart';

class PostImageGridTile extends StatelessWidget {
  const PostImageGridTile({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    if (imageUrl.contains('image')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface,
          ),
          child: FadedImageLoading(imageUrl: imageUrl),
        ),
      );
    } else if (imageUrl.contains('video')) {
      return FutureBuilder(
        future: VideoThumbnailServices.getVideoThumbnail(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.colorScheme.primaryContainer,
              ),
            );
          }
          if (snapshot.hasData) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface,
                  image: DecorationImage(
                    image: FileImage(File(snapshot.data!.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      );
    }
    return Container();
  }
}
