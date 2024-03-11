import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/edit_post/edit_post.dart';

class PostMoreWidget {
  static Future<dynamic> bottomSheet(
      {required BuildContext context,
      PostModel? postModel,
      required String userId,
      String? postId}) {
    return showModalBottomSheet(
      backgroundColor: kWhite,
      barrierColor: Colors.black26,
      useRootNavigator: true,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Container(
                height: 5,
                width: 50,
                margin: const EdgeInsets.fromLTRB(180, 20, 180, 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.bookmark_border_outlined),
                title: Text('Save'),
              ),
              if ((postModel!.user!['_id'] ?? postId) == userId)
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit post'),
                  onTap: () {
                    nextScreen(
                      context,
                      EditPostPage(
                        description: postModel.description,
                        location: postModel.location,
                        imageUrlList: postModel.mediaURL!,
                        postId: postModel.id!,
                      ),
                    );
                  },
                ),
              if ((postModel.user!['_id'] ?? postId)== userId)
                BlocListener<PostBloc, PostState>(
                  listener: (context, state) {
                    if (state is RemovePostSuccessState) {
                      Navigator.pop(context);
                      context.read<PostBloc>().add(PostInitialFetchEvent());
                      context
                          .read<ProfileBloc>()
                          .add(UserDetailInitialFetchEvent());
                    }
                  },
                  child: ListTile(
                    leading: const Icon(Icons.delete),
                    title: const Text('Remove post'),
                    onTap: () {
                      context
                          .read<PostBloc>()
                          .add(RemovePostEvent(postId: postModel.id!));
                    },
                  ),
                ),
              if ((postModel.user!['_id'] ?? postId) != userId)
                const ListTile(
                  leading: Icon(Icons.report_sharp),
                  title: Text('Report'),
                ),
              if ((postModel.user!['_id'] ?? postId) != userId)
                const ListTile(
                  leading: Icon(Icons.person),
                  title: Text('View account'),
                )
            ],
          ),
        );
      },
    );
  }
}
