import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CreatePostAppbar extends StatelessWidget {
  const CreatePostAppbar({super.key});

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
          onTap: () {},
          child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'POST',
                style:
                    TextStyle(fontVariations: fontWeightW500, color: kDarkBlue),
              )),
        )
      ],
    );
  }
}
