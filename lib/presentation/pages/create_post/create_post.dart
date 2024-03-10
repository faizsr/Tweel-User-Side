import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/create_post/widgets/bottom_image_listview.dart';
import 'package:tweel_social_media/presentation/pages/create_post/widgets/create_post_appbar.dart';
import 'package:tweel_social_media/presentation/pages/create_post/widgets/user_detail_widget.dart';
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: BlocListener<PostBloc, PostState>(
          listener: (context, state) {
            if (state is CreatePostLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  backgroundColor: kBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  behavior: SnackBarBehavior.floating,
                  content: const Row(
                    children: [
                      Text('Uploading...'),
                      Spacer(),
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            if (state is UploadImageSuccessState) {
              context.read<PostBloc>().add(
                    CreatePostEvent(
                      postModel: PostModel(
                        description: descriptionController.text,
                        location: locationController.text,
                        mediaURL: state.imagePathList,
                      ),
                    ),
                  );
            }
            if (state is CreatePostSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              customSnackbar(context, 'New post uploaded successfully');
              context.read<PostBloc>().add(PostInitialFetchEvent());
              context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
            }
          },
          child: CreatePostAppbar(
            selectedAssets: widget.selectedAssetList,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
      bottomSheet:
          BottomImageListview(selectedAssetList: widget.selectedAssetList),
    );
  }
}
