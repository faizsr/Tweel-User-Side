import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/image_preview_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/media_picker/media_picker_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/story/story_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/create_post.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/widgets/media_picker_appbar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum ScreenType { post, story, profile }

class MediaPicker extends StatefulWidget {
  const MediaPicker(
      {super.key,
      required this.maxCount,
      required this.requestType,
      required this.screenType,
      this.userId});

  final int maxCount;
  final RequestType requestType;
  final ScreenType screenType;
  final String? userId;

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  List<AssetEntity> selectedAssetList = [];

  @override
  void initState() {
    context
        .read<MediaPickerBloc>()
        .add(LoadAlbumsAndAssetsEvent(requestType: RequestType.common));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: BlocBuilder<MediaPickerBloc, MediaPickerState>(
            builder: (context, state) {
              if (state is MediaSuccessState) {
                debugPrint('Selected Album: ${state.selectedAlbum}');
                debugPrint(
                    'Length of album after selecting ${state.albumList.length}');
                return MediaPickerAppbar(
                  albumList: state.albumList,
                  selectedAlbum: state.selectedAlbum ?? state.albumList[0],
                  selectedAssetList: selectedAssetList,
                  onChanged: (AssetPathEntity? value) {
                    context.read<MediaPickerBloc>().add(LoadSelectedAssetEvent(
                        selectedAlbum: value, albumList: state.albumList));
                  },
                  onPressed: () {
                    if (widget.screenType == ScreenType.post) {
                      nextScreen(context,
                          CreatePostPage(selectedAssetList: selectedAssetList));
                    } else if (widget.screenType == ScreenType.profile) {
                      context
                          .read<SetProfileImageCubit>()
                          .setProfileImage(selectedAssetList);
                      Navigator.of(context).pop(selectedAssetList);
                    } else if (widget.screenType == ScreenType.story) {
                      context.read<StoryBloc>().add(
                            AddStoryEvent(
                              userId: widget.userId!,
                              selectedAssets: selectedAssetList,
                            ),
                          );
                    }
                  },
                );
              }
              return Container();
            },
          ),
        ),
        body: BlocBuilder<MediaPickerBloc, MediaPickerState>(
          builder: (context, state) {
            if (state is MediaSuccessState) {
              if (state.assetList.isEmpty) {
                return const Center(
                  child: Text('No albums found'),
                );
              } else {
                return GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.assetList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    AssetEntity assetEntity = state.assetList[index];
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: assetWidget(assetEntity, state.assetList),
                    );
                  },
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget assetWidget(AssetEntity assetEntity, List<AssetEntity> assetList) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              selectAsset(assetEntity: assetEntity);
            },
            onLongPress: () async {
              debugPrint('Long press to view');
              await AssetPickerViewer.pushToViewer(
                context,
                previewAssets: assetList,
                themeData: imagePreviewlightTheme,
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: AssetEntityImage(
                assetEntity,
                isOriginal: false,
                opacity: AlwaysStoppedAnimation(
                    selectedAssetList.contains(assetEntity) == true ? 0.8 : 1),
                thumbnailSize: const ThumbnailSize.square(250),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        if (assetEntity.type == AssetType.video)
          Positioned(
            bottom: 2,
            left: 5,
            child: Row(
              children: [
                const Icon(
                  Icons.videocam_rounded,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(
                  '${formattedTime(timeInSecond: assetEntity.duration)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: selectedAssetList.contains(assetEntity) == true
                    ? Colors.white
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  '${selectedAssetList.indexOf(assetEntity) + 1}',
                  style: TextStyle(
                    color: selectedAssetList.contains(assetEntity) == true
                        ? Colors.black
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void selectAsset({required AssetEntity assetEntity}) {
    if (selectedAssetList.contains(assetEntity)) {
      setState(() {
        selectedAssetList.remove(assetEntity);
      });
    } else if (selectedAssetList.length < widget.maxCount) {
      setState(() {
        selectedAssetList.add(assetEntity);
      });
    }
  }
}
