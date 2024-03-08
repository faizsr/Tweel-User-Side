import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/presentation/bloc/comment/comment_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';

class CommentTextFieldWidget extends StatefulWidget {
  const CommentTextFieldWidget({
    super.key,
    required this.postModel,
    required this.onTap,
    required this.onChanged,
  });

  final PostModel postModel;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  State<CommentTextFieldWidget> createState() => _CommentTextFieldWidgetState();
}

class _CommentTextFieldWidgetState extends State<CommentTextFieldWidget> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is UserDetailFetchingSucessState) {
          return BottomAppBar(
            padding: EdgeInsets.zero,
            elevation: 0,
            notchMargin: 0,
            height: 60,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 0.5,
                    color: kGray,
                  ),
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(state.userDetails.profilePicture!),
                  ),
                  kWidth(10),
                  Expanded(
                    child: TextFormField(
                      onTap: widget.onTap,
                      onChanged: widget.onChanged,
                      controller: commentController,
                      decoration: const InputDecoration(
                        hintText: 'Add a comment...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      context.read<CommentBloc>().add(AddCommentEvent(
                            postId: widget.postModel.id,
                            comment: commentController.text,
                            postModel: widget.postModel,
                            userModel: state.userDetails,
                          ));
                      commentController.clear();
                    },
                    child: const Icon(CustomIcons.send_2),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
