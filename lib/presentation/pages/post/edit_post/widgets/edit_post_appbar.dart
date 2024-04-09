import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/post_edit/post_edit_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';

class EditPostAppbar extends StatelessWidget {
  const EditPostAppbar({
    super.key,
    required this.onTap,
    required this.onDetail,
  });

  final void Function()? onTap;
  final bool onDetail;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AppBar(
      toolbarHeight: 40,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: theme.colorScheme.surface,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
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
        BlocConsumer<PostEditBloc, PostEditState>(
          listener: (context, state) {
            if (state is EditPostSuccessState) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              if (onDetail) {
                Navigator.of(context).pop();
              }
              context.read<PostBloc>().add(PostInitialFetchEvent());
              context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
            }
          },
          builder: (context, state) {
            if (state is EditPostLoadingState) {
              return Container(
                height: 15,
                width: 15,
                margin: const EdgeInsets.only(right: 10),
                child: CircularProgressIndicator(
                  color: theme.colorScheme.onPrimary,
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
                    color: theme.colorScheme.onPrimary,
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
