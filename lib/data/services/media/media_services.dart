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

  Future<List<AssetEntity>> loadAssets(AssetPathEntity selectedAlbum) async {
    List<AssetEntity> assetList = await selectedAlbum.getAssetListRange(
      start: 0,
      end: await selectedAlbum.assetCountAsync,
    );
    return assetList;
  }
}
