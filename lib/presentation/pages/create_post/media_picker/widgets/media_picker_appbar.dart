import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/create_post/create_post.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MediaPickerAppbar extends StatefulWidget {
  const MediaPickerAppbar({
    super.key,
    required this.selectedAssetList,
    required this.albumList,
    required this.selectedAlbum,
    required this.onChanged,
  });

  final List<AssetEntity> selectedAssetList;
  final List<AssetPathEntity> albumList;
  final AssetPathEntity? selectedAlbum;
  final void Function(AssetPathEntity?)? onChanged;

  @override
  State<MediaPickerAppbar> createState() => _MediaPickerAppbarState();
}

class _MediaPickerAppbarState extends State<MediaPickerAppbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _mediaAppbar(context),
        const SizedBox(
          height: 10,
        ),
        _mediaDropdown(),
      ],
    );
  }

  DropdownButtonHideUnderline _mediaDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<AssetPathEntity>(
        isDense: true,
        isExpanded: false,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 40,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          iconSize: 18,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 300,
          width: double.infinity,
          elevation: 2,
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        value: widget.selectedAlbum,
        onChanged: widget.onChanged,
        items: widget.albumList
            .map<DropdownMenuItem<AssetPathEntity>>((AssetPathEntity album) {
          return DropdownMenuItem<AssetPathEntity>(
            value: album,
            child: FutureBuilder<int>(
              future: album.assetCountAsync,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(album.name);
                } else {
                  return Text(album.name);
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  AppBar _mediaAppbar(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      automaticallyImplyLeading: false,
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.close,
          size: 22,
        ),
      ),
      titleSpacing: 0,
      centerTitle: true,
      title: const Text(
        'Select Media',
        style: TextStyle(fontSize: 18, fontVariations: fontWeightW600),
      ),
      actions: [
        widget.selectedAssetList.isNotEmpty
            ? IconButton(
                onPressed: () {
                  nextScreen(
                    context,
                    CreatePostPage(
                      selectedAssetList: widget.selectedAssetList,
                    ),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                  size: 22,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
