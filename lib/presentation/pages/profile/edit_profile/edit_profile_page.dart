import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/set_profile_image/cubit/set_profile_image_cubit.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/widgets/create_loading_snackbar.dart';
import 'package:tweel_social_media/presentation/pages/profile/edit_profile/widgets/edit_appbar.dart';
import 'package:tweel_social_media/presentation/pages/profile/edit_profile/widgets/edit_form_field.dart';
import 'package:tweel_social_media/presentation/pages/profile/edit_profile/widgets/profile_picture.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final fullnameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final emailController = TextEditingController();
  final phonenumberController = TextEditingController();

  @override
  void initState() {
    fullnameController.text = widget.user.fullName!;
    usernameController.text = widget.user.username!;
    bioController.text = widget.user.bio!;
    emailController.text = widget.user.email!;
    phonenumberController.text = widget.user.phoneNumber.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: EditProfileAppbar(
          fullnameController: fullnameController,
          widget: widget,
          usernameController: usernameController,
          bioController: bioController,
          showCheckIcon: true,
        ),
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is EditUserDetailsSuccessState) {
            Navigator.pop(context);
            context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
            context.read<PostBloc>().add(PostInitialFetchEvent());
            context.read<SetProfileImageCubit>().resetState();
          }
          if (state is EditUsernameAlreadyExistsState) {
            customSnackbar(context, 'Username already taken');
          }
          if (state is EditUserDetailsLoadingState) {
            CreateLoadingSnackbar.showSnackbar(context);
          }
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          children: [
            ProfilePictureWidget(widget: widget),
            kHeight(30),
            EditFormField(
              fullnameController: fullnameController,
              usernameController: usernameController,
              bioController: bioController,
              emailController: emailController,
              phonenumberController: phonenumberController,
            ),
          ],
        ),
      ),
    );
  }
}
