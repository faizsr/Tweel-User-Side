import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class EditPostAppbar extends StatelessWidget {
  const EditPostAppbar({super.key, required this.onTap});

  final void Function()? onTap;

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
        'Edit post details',
        style: TextStyle(fontSize: 18, fontVariations: fontWeightW600),
      ),
      actions: [
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              'DONE',
              style:
                  TextStyle(fontVariations: fontWeightW500, color: kDarkBlue),
            ),
          ),
        ),
      ],
    );
  }
}