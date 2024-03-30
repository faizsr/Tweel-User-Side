import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/profile_logics/profile_logics_bloc.dart';
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
        icon: const Icon(Ktweel.arrow_left),
      ),
      actions: [
        MultiBlocBuilder(
          blocs: [
            context.watch<SetProfileImageCubit>(),
            context.watch<ProfileLogicsBloc>(),
          ],
          builder: (context, state) {
            var state1 = state[0];
            var state2 = state[1];
            if (state1 is SetProfileImageSuccessState) {
              selectedImage = state1.selectedImage;
            }
            if (state2 is EditUserDetailsLoadingState) {
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
            return IconButton(
              onPressed: () async {
                if (_canSaveChanges()) {
                  UserModel updatedUser = UserModel(
                    fullName: widget.fullnameController.text,
                    username: widget.usernameController.text,
                    bio: widget.bioController.text,
                    profilePicture: widget.widget.user.profilePicture,
                  );
                  context.read<ProfileLogicsBloc>().add(
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
