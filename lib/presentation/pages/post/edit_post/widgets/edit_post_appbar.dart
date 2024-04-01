import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/post_logics/post_logics_bloc.dart';

class EditPostAppbar extends StatelessWidget {
  const EditPostAppbar({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 40,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        icon: const Icon(
          Ktweel.close,
          size: 26,
        ),
      ),
      titleSpacing: 0,
      centerTitle: true,
      title: const Text(
        'Edit post details',
        style: TextStyle(fontSize: 18, fontVariations: fontWeightW600),
      ),
      actions: [
        BlocBuilder<PostLogicsBloc, PostLogicsState>(
          builder: (context, state) {
            if (state is EditPostLoadingState) {
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
                  'DONE',
                  style: TextStyle(
                    fontVariations: fontWeightW500,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
