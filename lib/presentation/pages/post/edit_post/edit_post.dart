import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/widgets/user_detail_widget.dart';
import 'package:tweel_social_media/presentation/pages/post/edit_post/widgets/edit_bottom_image_listview.dart';
import 'package:tweel_social_media/presentation/pages/post/edit_post/widgets/edit_post_appbar.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({
    super.key,
    required this.location,
    required this.description,
    required this.imageUrlList,
    required this.postId,
  });

  final String location;
  final String description;
  final List imageUrlList;
  final String postId;

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final List<AssetEntity> selectedAssets = [];

  @override
  void initState() {
    locationController.text = widget.location;
    descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: EditPostAppbar(
          onTap: () {
            context.read<PostBloc>().add(
                  EditPostEvent(
                    postModel: PostModel(
                      id: widget.postId,
                      description: descriptionController.text,
                      location: locationController.text,
                      mediaURL: widget.imageUrlList,
                    ),
                  ),
                );
          },
        ),
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is EditPostSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
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
                TextFormField(
                  controller: locationController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    hintText: 'Enter location',
                    border: InputBorder.none,
                  ),
                ),
                TextFormField(
                  controller: descriptionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'What do you want to talk about?',
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: EditBottomImageListview(imageUrlList: widget.imageUrlList),
    );
  }
}
