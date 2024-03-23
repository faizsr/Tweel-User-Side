// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
// import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/widgets/bottom_image_listview.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/widgets/create_loading_snackbar.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/widgets/create_post_appbar.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/widgets/user_detail_widget.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({
    super.key,
    required this.selectedAssetList,
  });

  final List<AssetEntity> selectedAssetList;
  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    changeSystemThemeOnPopup(color: isDarkMode ? dBlueGrey : dWhite);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: CreatePostAppbar(
          onTap: () {
            print(descriptionController.text);
            print(locationController.text);
            print(widget.selectedAssetList.length);
            context.read<PostBloc>().add(
                  CreatePostEvent(
                    description: descriptionController.text,
                    location: locationController.text,
                    selectedAssets: widget.selectedAssetList,
                  ),
                );
          },
        ),
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is CreatePostLoadingState) {
            CreateLoadingSnackbar.showSnackbar(context);
          }
          if (state is CreatePostSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            customSnackbar(context, 'New post uploaded successfully');
            context.read<PostBloc>().add(PostInitialFetchEvent());
            context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                const UserDetailWidget(),
                kHeight(20),
                createPostTextField(
                    context: context,
                    controller: locationController,
                    hintText: 'Enter location'),
                createPostTextField(
                    context: context,
                    controller: descriptionController,
                    hintText: 'What do you want to talk about?'),
              ],
            ),
          ),
        ),
      ),
      bottomSheet:
          BottomImageListview(selectedAssetList: widget.selectedAssetList),
    );
  }

  TextFormField createPostTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        border: InputBorder.none,
      ),
    );
  }
}
