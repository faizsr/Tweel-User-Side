import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/cubit/post_image_index.dart/post_image_index.dart';

class PostImagePreview extends StatefulWidget {
  const PostImagePreview({
    super.key,
    required this.mediaUrl,
    required this.currentIndex,
  });

  final List mediaUrl;
  final int currentIndex;

  @override
  State<PostImagePreview> createState() => _PostImagePreviewState();
}

class _PostImagePreviewState extends State<PostImagePreview> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.currentIndex);
    if (widget.currentIndex != 0) {
      context.read<PostImageIndexCubit>().onPageChange(widget.currentIndex);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    changeSystemThemeOnPopup(context: context, color: lBlack);
    return BlocBuilder<PostImageIndexCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: lBlack,
          appBar: AppBar(
            backgroundColor: lBlack,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Ktweel.close,
                size: 30,
                color: lWhite,
              ),
            ),
            centerTitle: true,
            title: Text(
              '${state + 1} / ${widget.mediaUrl.length}',
              style: const TextStyle(color: lWhite, fontSize: 18),
            ),
          ),
          body: GestureDetector(
            onVerticalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dy > sensitivity) {
                Navigator.pop(context);
              }
            },
            child: PageView.builder(
              controller: pageController,
              itemCount: widget.mediaUrl.length,
              onPageChanged: (value) {
                context.read<PostImageIndexCubit>().onPageChange(value);
              },
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(20.0),
                  minScale: 0.1,
                  maxScale: 5.0,
                  trackpadScrollCausesScale: true,
                  child: Image(
                    image: NetworkImage(
                      widget.mediaUrl[index],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
