part of 'media_picker_bloc.dart';

@immutable
sealed class MediaPickerEvent {}

class LoadAlbumsAndAssetsEvent extends MediaPickerEvent {
  final RequestType requestType;
  final bool onRefresh;
  final bool onAlbumChange;
  final AssetPathEntity? currentAlbum;

  LoadAlbumsAndAssetsEvent({
    required this.requestType,
    this.onRefresh = false,
    this.onAlbumChange = false,
    this.currentAlbum,
  });
}

class SelectAssetEvent extends MediaPickerEvent {
  final AssetEntity assetEntity;
  final List<AssetEntity> assetList;
  final AssetPathEntity? selectedAlbum;
  final List<AssetPathEntity> albumList;

  SelectAssetEvent({
    required this.assetList,
    required this.selectedAlbum,
    required this.albumList,
    required this.assetEntity,
  });
}

class UnselectAssetEvent extends MediaPickerEvent {
  final AssetEntity assetEntity;
  final List<AssetEntity> assetList;
  final AssetPathEntity? selectedAlbum;
  final List<AssetPathEntity> albumList;

  UnselectAssetEvent({
    required this.assetList,
    required this.selectedAlbum,
    required this.albumList,
    required this.assetEntity,
  });
}
