import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/post_logics/post_logics_bloc.dart';

class CreatePostAppbar extends StatelessWidget {
  const CreatePostAppbar({
    super.key,
    required this.onTap,
  });

  final void Function()? onTap;

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
        BlocBuilder<PostLogicsBloc, PostLogicsState>(
          builder: (context, state) {
            if (state is CreatePostLoadingState) {
              return Container(
                height: 15,
                width: 15,
                margin: const EdgeInsets.only(right: 10),
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.onPrimary,
                  strokeWidth: 2,
                ),
              );
            }
            return InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'POST',
                  style: TextStyle(
                      fontVariations: fontWeightW500,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
