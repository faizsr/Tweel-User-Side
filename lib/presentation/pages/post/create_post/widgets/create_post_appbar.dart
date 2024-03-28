import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CreatePostAppbar extends StatefulWidget {
  const CreatePostAppbar({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

  @override
  State<CreatePostAppbar> createState() => _CreatePostAppbarState();
}

class _CreatePostAppbarState extends State<CreatePostAppbar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        'Create New Post',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              'POST',
              style: TextStyle(
                  fontVariations: fontWeightW500,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
