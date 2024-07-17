// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/presentation/bloc/media_picker/media_picker_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_image_preview_page.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/create_post.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/smart_refresher.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/widgets/asset_card_widget.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/widgets/media_picker_appbar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum ScreenType { post, story, profile }

class MediaPicker extends StatefulWidget {
  const MediaPicker({
    super.key,
    required this.maxCount,
    required this.requestType,
    required this.screenType,
    this.userId,
  });

  final int maxCount;
  final RequestType requestType;
  final ScreenType screenType;
  final String? userId;

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();
  List<AssetEntity> selectedAssetList = [];
  AssetPathEntity? currentAlbum;
  int assetLength = 0;

  @override
  void initState() {
    context.read<MediaPickerBloc>().add(LoadAlbumsAndAssetsEvent(
        requestType: RequestType.common, onRefresh: true));
    super.initState();
  }

  Future<void> onRefresh() async {
    context.read<MediaPickerBloc>().add(LoadAlbumsAndAssetsEvent(
          currentAlbum: currentAlbum,
          requestType: RequestType.common,
          onRefresh: true,
        ));
    await Future.delayed(const Duration(seconds: 1));
    refreshController.refreshCompleted();
  }

  Future<void> onLoading() async {
    context.read<MediaPickerBloc>().add(LoadAlbumsAndAssetsEvent(
          currentAlbum: currentAlbum,
          requestType: RequestType.common,
          onRefresh: false,
        ));
    int end = context.read<MediaPickerBloc>().end;
    await Future.delayed(const Duration(seconds: 1));
    if (end == assetLength) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
  }

  void onAlbumChange(AssetPathEntity? album) {
    currentAlbum = album;
    context.read<MediaPickerBloc>().add(LoadAlbumsAndAssetsEvent(
          currentAlbum: album,
          requestType: widget.requestType,
          onRefresh: true,
          onAlbumChange: true,
        ));
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ColorfulSafeArea(
      color: theme.colorScheme.surface,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: BlocBuilder<MediaPickerBloc, MediaPickerState>(
            builder: (context, state) {
              if (state is MediaSuccessState) {
                return MediaPickerAppbar(
                  albumList: state.albumList,
                  selectedAlbum: state.selectedAlbum ?? state.albumList[0],
                  // selectedAssetList: selectedAssetList,
                  onChanged: onAlbumChange,
                  onPressed: onDonePressed,
                );
              }
              return const MediaAppbar();
            },
          ),
        ),
        body: CustomSmartRefresher(
          scrollController: scrollController,
          refreshController: refreshController,
          onRefresh: onRefresh,
          onLoading: onLoading,
          child: BlocBuilder<MediaPickerBloc, MediaPickerState>(
            builder: (context, state) {
              if (state is MediaSuccessState) {
                return GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.assetList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    assetLength = state.assetList.length;
                    log('Asset List Length Initial: $assetLength');
                    AssetEntity assetEntity = state.assetList[index];
                    selectedAssetList = state.selectedAssetList;
                    return Padding(
                      padding: const EdgeInsets.all(2),
                      child: AssetCardWidget(
                        assetEntity: assetEntity,
                        assetList: state.assetList,
                        selectedAssetList: selectedAssetList,
                        albumList: state.albumList,
                        selectedAlbum: currentAlbum,
                        maxCount: widget.maxCount,
                      ),
                    );
                  },
                );
              }
              if (state is MediaLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                    strokeWidth: 2,
                  ),
                );
              }
              return const Center(
                child: Text('Nothing to Load'),
              );
            },
          ),
        ),
      ),
    );
  }

  void onDonePressed() {
    var theme = Theme.of(context);
    if (widget.screenType == ScreenType.post) {
      changeSystemThemeOnPopup(
        color: theme.colorScheme.surface,
        context: context,
      );
      nextScreen(
        context,
        CreatePostPage(selectedAssetList: selectedAssetList),
      ).then((value) => changeSystemThemeOnPopup(
            color: theme.colorScheme.surface,
            context: context,
          ));
    } else if (widget.screenType == ScreenType.profile) {
      context.read<SetProfileImageCubit>().setProfileImage(selectedAssetList);
      Navigator.of(context).pop(selectedAssetList);
    } else if (widget.screenType == ScreenType.story) {
      nextScreen(
          context,
          StoryImagePreviewPage(
            mediaUrl: selectedAssetList,
            userId: widget.userId!,
          )).then(
        (value) => mySystemTheme(context),
      );
    }
  }
}
