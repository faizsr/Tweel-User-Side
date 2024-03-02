import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/create_post/widgets/bottom_image_listview.dart';
import 'package:tweel_social_media/presentation/pages/create_post/widgets/create_post_appbar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({
    super.key,
    required this.selectedAssetList,
  });

  final List<AssetEntity> selectedAssetList;
  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CreatePostAppbar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(radius: 25),
                  kWidth(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'John Mikkkke',
                        style: TextStyle(
                            fontVariations: fontWeightW600, fontSize: 15),
                      ),
                      kHeight(5),
                      const Text(
                        'Public',
                        style: TextStyle(
                          fontSize: 12,
                          color: kGray,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              kHeight(20),
              TextFormField(
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'What do you want to talk about?',
                  border: InputBorder.none,
                ),
              )
            ],
          ),
        ),
      ),
      bottomSheet:
          BottomImageListview(selectedAssetList: widget.selectedAssetList),
    );
  }
}
