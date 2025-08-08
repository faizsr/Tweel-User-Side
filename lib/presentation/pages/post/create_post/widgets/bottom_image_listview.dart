import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/image_preview_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class BottomImageListview extends StatefulWidget {
  const BottomImageListview({
    super.key,
    required this.selectedAssetList,
  });

  final List<AssetEntity> selectedAssetList;

  @override
  State<BottomImageListview> createState() => _BottomImageListviewState();
}

class _BottomImageListviewState extends State<BottomImageListview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      height: 100,
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.selectedAssetList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          AssetEntity assetEntity = widget.selectedAssetList[index];
          return Container(
            margin: const EdgeInsets.only(left: 15),
            width: 90,
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () async {
                      await AssetPickerViewer.pushToViewer(
                        context,
                        currentIndex: index,
                        previewAssets: widget.selectedAssetList,
                        themeData: imagePreviewlightTheme,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: AssetEntityImage(
                        assetEntity,
                        isOriginal: false,
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
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          formattedTime(timeInSecond: assetEntity.duration),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.selectedAssetList.contains(assetEntity)) {
                        setState(() {
                          widget.selectedAssetList.remove(assetEntity);
                        });
                      }
                    },
                    child: const CircleAvatar(
                      radius: 10,
                      backgroundColor: lWhite,
                      foregroundColor: lBlack,
                      child: Icon(
                        Ktweel.close,
                        size: 15,
                      ),
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
