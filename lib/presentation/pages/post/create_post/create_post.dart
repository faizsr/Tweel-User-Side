import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/post_logics/post_logics_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/widgets/bottom_image_listview.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: CreatePostAppbar(
            onTap: () {
              if (formKey.currentState!.validate()) {
                context.read<PostLogicsBloc>().add(
                      CreatePostEvent(
                        description: descriptionController.text,
                        location: locationController.text,
                        selectedAssets: widget.selectedAssetList,
                      ),
                    );
              }
            },
          ),
        ),
        body: BlocListener<PostLogicsBloc, PostLogicsState>(
          listener: (context, state) {
            if (state is CreatePostSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              customSnackbar(context, 'New post uploaded successfully',
                  leading: Ktweel.clipboard_tick, trailing: 'OK');
              context.read<PostBloc>().add(PostInitialFetchEvent());
              context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const UserDetailWidget(),
                    kHeight(20),
                    createPostTextField(
                      context: context,
                      controller: locationController,
                      hintText: 'Enter location',
                    ),
                    createPostTextField(
                      context: context,
                      controller: descriptionController,
                      hintText: 'What do you want to talk about?',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: BottomImageListview(
          selectedAssetList: widget.selectedAssetList,
        ),
      ),
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
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required.';
        }
        return '';
      },
    );
  }
}
