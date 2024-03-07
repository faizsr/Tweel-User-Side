import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/create_post/widgets/bottom_image_listview.dart';
import 'package:tweel_social_media/presentation/pages/create_post/widgets/create_post_appbar.dart';
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
  void initState() {
    context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: CreatePostAppbar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              userDetailWidget(),
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

  Widget userDetailWidget() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is UserDetailFetchingSucessState) {
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage:
                    NetworkImage(state.userDetails.profilePicture!),
              ),
              kWidth(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.userDetails.fullName!,
                    style: const TextStyle(
                      fontVariations: fontWeightW600,
                      fontSize: 15,
                    ),
                  ),
                  kHeight(5),
                  Text(
                    state.userDetails.accountType!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: kGray,
                    ),
                  ),
                ],
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
