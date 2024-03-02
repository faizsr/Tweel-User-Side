import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/create_post/media_picker/media_picker_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CreatePostCard extends StatelessWidget {
  const CreatePostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: [
          BoxShadow(
            blurRadius: 40,
            color: Colors.black.withOpacity(0.05),
          )
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 30),
              kWidth(20),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Share you thoughts',
                    style: TextStyle(
                      fontSize: 16,
                      fontVariations: fontWeightW500,
                    ),
                  ),
                  Text(
                    '@smithxavier',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          kHeight(20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(3),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                nextScreen(
                  context,
                  const MediaPicker(
                    maxCount: 10,
                    requestType: RequestType.common,
                  ),
                  // const CreatePostPage(),
                );
              },
              child: const Text(
                'CREATE NEW POST',
                style: TextStyle(
                  fontVariations: fontWeightW900,
                  color: kBlack,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
