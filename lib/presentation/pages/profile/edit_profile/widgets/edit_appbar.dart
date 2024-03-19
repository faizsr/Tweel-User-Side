// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:tweel_social_media/presentation/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class EditProfileAppbar extends StatefulWidget {
  const EditProfileAppbar({
    super.key,
    required this.fullnameController,
    required this.widget,
    required this.usernameController,
    required this.bioController,
    this.showCheckIcon = false,
  });

  final TextEditingController fullnameController;
  final EditProfilePage widget;
  final TextEditingController usernameController;
  final TextEditingController bioController;
  final bool showCheckIcon;

  @override
  State<EditProfileAppbar> createState() => _EditProfileAppbarState();
}

class _EditProfileAppbarState extends State<EditProfileAppbar> {
  List<AssetEntity> selectedImage = [];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Edit profile',
        style: TextStyle(fontSize: 18),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
          context.read<SetProfileImageCubit>().resetState();
        },
        icon: const Icon(CustomIcons.arrow_left),
      ),
      actions: [
        BlocBuilder<SetProfileImageCubit, SetProfileImageState>(
          builder: (context, state) {
            if (state is SetProfileImageSuccessState) {
              selectedImage = state.selectedImage;
            }
            return IconButton(
              onPressed: () async {
                print('ldjfladjk');
                if (_canSaveChanges()) {
                  UserModel updatedUser = UserModel(
                    fullName: widget.fullnameController.text,
                    username: widget.usernameController.text,
                    bio: widget.bioController.text,
                    profilePicture: widget.widget.user.profilePicture,
                  );
                  print('ldjfladjfldjf');
                  context.read<ProfileBloc>().add(
                        EditUserDetailEvent(
                          intialUser: widget.widget.user,
                          updatedUser: updatedUser,
                          profilePicture: selectedImage,
                        ),
                      );
                } else {
                  debugPrint('Nothing to change');
                }
              },
              icon: const Icon(Icons.done_rounded),
            );
          },
        )
      ],
      titleSpacing: 0,
    );
  }

  bool _canSaveChanges() {
    final fullname = widget.fullnameController.text;
    final username = widget.usernameController.text;
    final bio = widget.bioController.text;
    final user = widget.widget.user;

    return fullname != user.fullName ||
        username != user.username ||
        bio != user.bio ||
        selectedImage.isNotEmpty;
  }
}
