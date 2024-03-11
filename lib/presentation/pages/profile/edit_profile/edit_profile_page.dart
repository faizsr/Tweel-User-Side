import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/widgets/custom_btn.dart';
import 'package:tweel_social_media/presentation/widgets/custom_txt_form_field.dart';

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
        title: const Text('Edit profile'),
        titleSpacing: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        children: [
          CircleAvatar(
            radius: 90,
            backgroundImage: NetworkImage(widget.user.profilePicture!),
          ),
          kHeight(50),
          CustomTxtFormField(
            controller: fullnameController,
            hintText: 'Fullname',
          ),
          kHeight(20),
          CustomTxtFormField(
            controller: usernameController,
            hintText: 'Username',
          ),
          kHeight(20),
          CustomTxtFormField(
            controller: bioController,
            hintText: 'Bio',
          ),
          kHeight(20),
          CustomTxtFormField(
            controller: emailController,
            hintText: 'Email address',
          ),
          kHeight(20),
          CustomTxtFormField(
            controller: phonenumberController,
            hintText: 'Phone number',
          ),
          kHeight(20),
          CustomButton(
            onPressed: () {},
            buttonText: 'Save',
          ),
        ],
      ),
    );
  }
}
