part of 'media_picker_bloc.dart';

@immutable
sealed class MediaPickerState {}

final class MediaPickerInitial extends MediaPickerState {}

class MediaLoadingState extends MediaPickerState {}

class MediaSuccessState extends MediaPickerState {
  final List<AssetEntity> assetList;
  final AssetPathEntity? selectedAlbum;
  final List<AssetPathEntity> albumList;
  final List<AssetEntity> selectedAssetList;

  MediaSuccessState({
    required this.assetList,
    required this.albumList,
    this.selectedAlbum,
    required this.selectedAssetList,
  });
}

class MediaErrorState extends MediaPickerState {}

