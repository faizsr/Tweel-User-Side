import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweel_social_media/core/theme/image_preview_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/services/media/media_services.dart';
import 'package:tweel_social_media/presentation/pages/create_post/media_picker/widgets/media_picker_appbar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MediaPicker extends StatefulWidget {
  const MediaPicker({
    super.key,
    required this.maxCount,
    required this.requestType,
  });

  final int maxCount;
  final RequestType requestType;

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];

  @override
  void initState() {
    MediaServices().loadAlbums(widget.requestType).then(
      (value) {
        setState(() {
          albumList = value;
          selectedAlbum = value[0];
        });
        MediaServices().loadAssets(selectedAlbum!).then(
          (value) {
            setState(() {
              assetList = value;
            });
          },
        );
      },
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: MediaPickerAppbar(
          albumList: albumList,
          selectedAlbum: selectedAlbum,
          selectedAssetList: selectedAssetList,
          onChanged: (AssetPathEntity? value) {
            setState(() {
              selectedAlbum = value;
            });
            MediaServices().loadAssets(selectedAlbum!).then(
              (value) {
                setState(() {
                  assetList = value;
                });
              },
            );
          },
        ),
      ),
      body: assetList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              physics: const BouncingScrollPhysics(),
              itemCount: assetList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                AssetEntity assetEntity = assetList[index];
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: assetWidget(assetEntity),
                );
              },
            ),
    );
  }

  Widget assetWidget(AssetEntity assetEntity) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () {
              selectAsset(assetEntity: assetEntity);
            },
            onLongPress: () async {
              debugPrint('long press');
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
