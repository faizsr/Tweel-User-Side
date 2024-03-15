part of 'media_picker_bloc.dart';

@immutable
sealed class MediaPickerEvent {}

class LoadAlbumsAndAssetsEvent extends MediaPickerEvent {
  final RequestType requestType;

  LoadAlbumsAndAssetsEvent({
    required this.requestType,
  });
}

class LoadSelectedAssetEvent extends MediaPickerEvent {
  final AssetPathEntity? selectedAlbum;
  final List<AssetPathEntity> albumList;

  LoadSelectedAssetEvent({
    required this.selectedAlbum,
    required this.albumList,
  });
}

class SelectAssetEvent extends MediaPickerEvent {
  final AssetEntity assetEntity;
  final List<AssetPathEntity> albumList;
  final List<AssetEntity> assetList;
  final AssetPathEntity? selectedAlbum;

  SelectAssetEvent({
    required this.albumList,
    required this.assetList,
    required this.assetEntity,
    required this.selectedAlbum,
  });
}

class UnselectAssetEvent extends MediaPickerEvent {
  final AssetEntity assetEntity;
  final List<AssetPathEntity> albumList;
  final List<AssetEntity> assetList;
  final AssetPathEntity? selectedAlbum;

  UnselectAssetEvent({
    required this.albumList,
    required this.assetList,
    required this.assetEntity,
    required this.selectedAlbum,
  });
}
