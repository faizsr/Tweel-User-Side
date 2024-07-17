import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/image_preview_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/media_picker/media_picker_bloc.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetCardWidget extends StatefulWidget {
  final AssetEntity assetEntity;
  final List<AssetEntity> assetList;
  final List<AssetEntity> selectedAssetList;
  final List<AssetPathEntity> albumList;
  final AssetPathEntity? selectedAlbum;
  final int maxCount;

  const AssetCardWidget({
    super.key,
    required this.assetEntity,
    required this.assetList,
    required this.selectedAssetList,
    required this.maxCount,
    required this.albumList,
    this.selectedAlbum,
  });

  @override
  State<AssetCardWidget> createState() => _AssetCardWidgetState();
}

class _AssetCardWidgetState extends State<AssetCardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectAsset(assetEntity: widget.assetEntity);
      },
      onLongPress: () async {
        await AssetPickerViewer.pushToViewer(
          context,
          previewAssets: widget.assetList,
          themeData: imagePreviewlightTheme,
        );
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: AssetEntityImage(
                widget.assetEntity,
                isOriginal: false,
                opacity: AlwaysStoppedAnimation(
                  widget.selectedAssetList.contains(widget.assetEntity)
                      ? 0.8
                      : 1,
                ),
                thumbnailSize: const ThumbnailSize.square(250),
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
          if (widget.assetEntity.type == AssetType.video)
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
                    '${formattedTime(timeInSecond: widget.assetEntity.duration)}',
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
                  color: widget.selectedAssetList.contains(widget.assetEntity)
                      ? Colors.white
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    '${widget.selectedAssetList.indexOf(widget.assetEntity) + 1}',
                    style: TextStyle(
                      color:
                          widget.selectedAssetList.contains(widget.assetEntity)
                              ? Colors.black
                              : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void selectAsset({required AssetEntity assetEntity}) {
    if (widget.selectedAssetList.contains(assetEntity)) {
      context.read<MediaPickerBloc>().add(UnselectAssetEvent(
            assetEntity: assetEntity,
            albumList: widget.albumList,
            assetList: widget.assetList,
            selectedAlbum: widget.selectedAlbum,
          ));
    } else if (widget.selectedAssetList.length < widget.maxCount) {
      context.read<MediaPickerBloc>().add(SelectAssetEvent(
            assetEntity: assetEntity,
            albumList: widget.albumList,
            assetList: widget.assetList,
            selectedAlbum: widget.selectedAlbum,
          ));
    }
  }
}
