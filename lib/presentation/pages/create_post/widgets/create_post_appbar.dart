import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CreatePostAppbar extends StatelessWidget {
  const CreatePostAppbar({
    super.key,
    required this.selectedAssets,
  });

  final List<AssetEntity> selectedAssets;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      automaticallyImplyLeading: false,
      backgroundColor: kWhite,
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
        'Create New Post',
        style: TextStyle(fontSize: 18, fontVariations: fontWeightW600),
      ),
      actions: [
        InkWell(
          onTap: () {
            context
                .read<PostBloc>()
                .add(UploadImageToCloudEvent(selectedAssets: selectedAssets));
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              'POST',
              style:
                  TextStyle(fontVariations: fontWeightW500, color: kDarkBlue),
            ),
          ),
        ),
      ],
    );
  }
}
