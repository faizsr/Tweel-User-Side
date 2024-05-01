import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/story/story_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/post_image_index.dart/post_image_index.dart';
import 'package:tweel_social_media/presentation/widgets/custom_text_btn.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class StoryImagePreviewPage extends StatelessWidget {
  const StoryImagePreviewPage({
    super.key,
    required this.mediaUrl,
    required this.userId,
  });

  final List<AssetEntity> mediaUrl;
  final String userId;

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
            title: const Text(
              'Story Preview',
              style: TextStyle(color: lWhite, fontSize: 18),
            ),
            actions: [
              BlocBuilder<StoryBloc, StoryState>(
                builder: (context, state) {
                  return state is AddStoryLoadingState
                      ? Container(
                          height: 15,
                          width: 15,
                          margin: const EdgeInsets.only(right: 10),
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                            strokeWidth: 2,
                          ),
                        )
                      : CustomTextBtn(
                          onTap: () async {
                            context.read<StoryBloc>().add(AddStoryEvent(
                                  userId: userId,
                                  selectedAssets: mediaUrl,
                                ));
                          },
                          bntText: 'SHARE',
                        );
                },
              ),
            ],
          ),
          body: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: AssetEntityImage(
                mediaUrl[0],
                isOriginal: true,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Ktweel.info_rugged,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
