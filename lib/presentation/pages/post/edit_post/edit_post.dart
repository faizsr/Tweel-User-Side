import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/post_edit/post_edit_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/widgets/user_detail_widget.dart';
import 'package:tweel_social_media/presentation/pages/post/edit_post/widgets/edit_bottom_image_listview.dart';
import 'package:tweel_social_media/presentation/pages/post/edit_post/widgets/edit_post_appbar.dart';
import 'package:tweel_social_media/presentation/widgets/custom_textfield_2.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({
    super.key,
    required this.location,
    required this.description,
    required this.imageUrlList,
    required this.postId,
    required this.onDetail,
  });

  final String location;
  final String description;
  final List imageUrlList;
  final String postId;
  final bool onDetail;

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    locationController.text = widget.location;
    descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: EditPostAppbar(
          onDetail: widget.onDetail,
          onTap: () {
            context.read<PostEditBloc>().add(
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              const UserDetailWidget(),
              kHeight(20),
              CustomTextField2(
                controller: locationController,
                hintText: 'Enter location',
              ),
              CustomTextField2(
                maxLines: 14,
                controller: descriptionController,
                hintText: 'What do you want to talk about?',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: EditBottomImageListview(imageUrlList: widget.imageUrlList),
    );
  }
}
