import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/cubit/post_image_index.dart/post_image_index.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_image_preview.dart';
import 'package:tweel_social_media/presentation/widgets/video_player.dart';

class PostImageWidget extends StatelessWidget {
  const PostImageWidget({
    super.key,
    required this.postModel,
    required this.height,
    this.onDetail = false,
  });

  final PostModel postModel;
  final double height;
  final bool onDetail;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      height: height,
      child: PageView.builder(
        itemCount: postModel.mediaURL!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              debugPrint('Image preview');
              nextScreen(
                context,
                PostImagePreview(
                  mediaUrl: postModel.mediaURL!,
                  currentIndex: index,
                ),
              ).then((value) {
                mySystemTheme(context);
                if (onDetail) {
                  changeSystemThemeOnPopup(
                    color: theme.colorScheme.surface,
                    context: context,
                  );
                }
                context.read<PostImageIndexCubit>().onPageChange(0);
              });
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Hero(
                  tag: 'image-pre${postModel.mediaURL![0].toString()}',
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: postModel.mediaURL![index]
                              .toString()
                              .contains('image')
                          ? Image.network(
                              postModel.mediaURL![index],
                              fit: BoxFit.cover,
                            )
                          : VideoPlayerWidget(
                              videoUrl: postModel.mediaURL![index],
                            ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: lBlack,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    child: Text(
                      '${index + 1} / ${postModel.mediaURL!.length}',
                      style: const TextStyle(color: lWhite, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
