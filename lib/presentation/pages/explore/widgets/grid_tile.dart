import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tweel_social_media/data/services/video_thumbnail/video_thumbnail_services.dart';

class VideoTile extends StatelessWidget {
  const VideoTile({
    super.key,
    required this.url,
    required this.height,
    required this.onTap,
  });

  final String url;
  final double height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return FutureBuilder(
      future: VideoThumbnailServices.getVideoThumbnail(url),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onTap: onTap,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                image: DecorationImage(
                  image: Image.file(File(snapshot.data!.path)).image,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    super.key,
    required this.height,
    required this.imageUrl,
    required this.onTap,
  });

  final double height;
  final String imageUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }
}
