import 'dart:developer';

import 'package:photo_manager/photo_manager.dart';

class MediaServices {
  Future<List<AssetPathEntity>> loadAlbums(RequestType requestType) async {
    var permission = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumList = [];
    if (permission.isAuth == true) {
      albumList = await PhotoManager.getAssetPathList(
        filterOption: FilterOptionGroup(
            videoOption: const FilterOption(
          durationConstraint: DurationConstraint(
            max: Duration(minutes: 2),
          ),
        )),
        type: requestType,
      );
    } else {
      PhotoManager.openSetting();
    }
    return albumList;
  }

  Future<List<AssetEntity>> loadAssets(
      AssetPathEntity selectedAlbum, int end) async {
    final count = await selectedAlbum.assetCountAsync;
    List<AssetEntity> assetList = [];

    if (end <= count) {
      if (count - end < 24) {
        end += count - end;
      }
      int start = end - 24;
      log('Start $start');
      log('End $end');
      log('Total: $count');
      assetList = await selectedAlbum.getAssetListRange(start: start, end: end);
      return assetList;
    }
    return assetList;
  }
}
