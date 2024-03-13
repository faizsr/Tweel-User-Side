import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/media_picker_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
      appBar: AppBar(
        title: const Text('Edit profile', style: TextStyle(fontSize: 18)),
        titleSpacing: 0,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is EditUserDetailsSuccessState) {
            Navigator.pop(context);
            context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
            context.read<PostBloc>().add(PostInitialFetchEvent());
          }
        },
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          children: [
            GestureDetector(
              onTap: () {
                nextScreen(
                  context,
                  const MediaPicker(
                    maxCount: 1,
                    requestType: RequestType.image,
                  ),
                );
              },
              child: CircleAvatar(
                radius: 90,
                backgroundImage: NetworkImage(widget.user.profilePicture!),
              ),
            ),
            kHeight(50),
            CustomTxtFormField(
              labelText: 'Full name',
              controller: fullnameController,
              hintText: 'Fullname',
            ),
            kHeight(20),
            CustomTxtFormField(
              labelText: 'Username',
              controller: usernameController,
              hintText: 'Username',
            ),
            kHeight(20),
            CustomTxtFormField(
              labelText: 'Bio',
              controller: bioController,
              hintText: 'Bio',
            ),
            kHeight(20),
            CustomTxtFormField(
              readOnly: true,
              labelText: 'Email address',
              controller: emailController,
              hintText: 'Email address',
            ),
            kHeight(20),
            CustomTxtFormField(
              readOnly: true,
              labelText: 'Phone number',
              controller: phonenumberController,
              hintText: 'Phone number',
            ),
            kHeight(20),
            CustomButton(
              onPressed: () {
                // if (usernameController.text != usernameController.text) {
                UserModel user = UserModel(
                  fullName: fullnameController.text,
                  username: usernameController.text,
                  bio: bioController.text,
                  profilePicture: widget.user.profilePicture,
                );
                context
                    .read<ProfileBloc>()
                    .add(EditUserDetailEvent(user: user));
                // }
              },
              buttonText: 'Save',
            ),
          ],
        ),
      ),
    );
  }
}
