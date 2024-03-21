import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/media_picker_page.dart';
import 'package:tweel_social_media/presentation/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    required this.widget,
  });

  final EditProfilePage widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
          context,
          const MediaPicker(
            maxCount: 1,
            requestType: RequestType.image,
            screenType: ScreenType.profile,
          ),
        );
      },
      child: CircleAvatar(
        radius: 80,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: BlocBuilder<SetProfileImageCubit, SetProfileImageState>(
          builder: (context, state) {
            if (state is SetProfileImageSuccessState) {
              return CircleAvatar(
                radius: 63,
                backgroundImage: AssetEntityImage(state.selectedImage[0]).image,
              );
            }
            return CircleAvatar(
              radius: 63,
              backgroundImage: NetworkImage(widget.user.profilePicture!),
            );
          },
        ),
      ),
    );
  }
}
