import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/services/media/media_services.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'media_picker_event.dart';
part 'media_picker_state.dart';

class MediaPickerBloc extends Bloc<MediaPickerEvent, MediaPickerState> {
  List<AssetEntity> selectedAssetList = [];
  List<AssetEntity> assetList = [];
  List<AssetPathEntity> albumList = [];
  int end = 24;

  MediaPickerBloc() : super(MediaPickerInitial()) {
    on<LoadAlbumsAndAssetsEvent>(loadAlbumsAndAssetsEvent);
    on<SelectAssetEvent>(selectAssetEvent);
    on<UnselectAssetEvent>(unselectAssetEvent);
  }

  FutureOr<void> loadAlbumsAndAssetsEvent(
      LoadAlbumsAndAssetsEvent event, Emitter<MediaPickerState> emit) async {
    if (event.onRefresh) {
      if (!event.onAlbumChange) selectedAssetList.clear();
      end = 24;
      emit(MediaLoadingState());
      albumList = await MediaServices().loadAlbums(event.requestType);
      AssetPathEntity currentAlbum = event.currentAlbum ?? albumList[0];
      if (albumList.isNotEmpty) {
        log('Album list refresh: ${currentAlbum.name}');
        assetList = await MediaServices().loadAssets(currentAlbum, 24);
      }
      if (assetList.isNotEmpty) {
        emit(MediaSuccessState(
          albumList: albumList,
          assetList: assetList,
          selectedAlbum: currentAlbum,
          selectedAssetList: selectedAssetList
        ));
      }
    } else {
      albumList = await MediaServices().loadAlbums(event.requestType);
      AssetPathEntity currentAlbum = event.currentAlbum ?? albumList[0];
      end += 24;

      if (albumList.isNotEmpty) {
        var assets = await MediaServices().loadAssets(currentAlbum, end);
        log('Album list not refresh: ${currentAlbum.name}');
        if (assets.isNotEmpty) {
          assetList.addAll(await MediaServices().loadAssets(currentAlbum, end));
        }
      }
      if (assetList.isNotEmpty) {
        emit(MediaSuccessState(
          albumList: albumList,
          assetList: assetList,
          selectedAlbum: currentAlbum,
          selectedAssetList: selectedAssetList,
        ));
      }
    }
  }

  FutureOr<void> selectAssetEvent(
      SelectAssetEvent event, Emitter<MediaPickerState> emit) {
    selectedAssetList.add(event.assetEntity);
    log('Selecting asset after length: ${selectedAssetList.length}');
    emit(MediaSuccessState(
      albumList: albumList,
      assetList: assetList,
      selectedAlbum: event.selectedAlbum ?? albumList[0],
      selectedAssetList: selectedAssetList,
    ));
  }

  FutureOr<void> unselectAssetEvent(
      UnselectAssetEvent event, Emitter<MediaPickerState> emit) {
    selectedAssetList.remove(event.assetEntity);
    log('Unselecting asset after length: ${selectedAssetList.length}');
    emit(MediaSuccessState(
      albumList: albumList,
      assetList: assetList,
      selectedAlbum: event.selectedAlbum ?? albumList[0],
      selectedAssetList: selectedAssetList,
    ));
  }
}
