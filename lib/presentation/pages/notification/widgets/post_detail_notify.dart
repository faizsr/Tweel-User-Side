import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/post_by_id/post_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/widgets/comment_text_field.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/widgets/comments_area_widget.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/widgets/detail_post_action_btns.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar_2.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_image_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_user_widget.dart';

class PostDetailNotify extends StatefulWidget {
  const PostDetailNotify({
    super.key,
    required this.postId,
    required this.currentUser,
  });

  final String postId;
  final UserModel? currentUser;

  @override
  State<PostDetailNotify> createState() => _PostDetailNotifyState();
}

class _PostDetailNotifyState extends State<PostDetailNotify> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context.read<PostByIdBloc>().add(FetchPostByIdEvent(postId: widget.postId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppbar2(
          backgroundColor: theme.colorScheme.surface,
          title: 'Post',
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
      ),
      body: BlocBuilder<PostByIdBloc, PostByIdState>(
        builder: (context, state) {
          if (state is FetchPostByIdLoadingState) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }
          if (state is FetchPostByIdSuccessState) {
            return Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      children: [
                        // ============= Posted User Detial =============
                        PostUserDetail(
                          postModel: state.postModel,
                          userModel: widget.currentUser,
                          onDetail: true,
                        ),
                        kHeight(20),

                        // ============= Post Description =============
                        Text(
                          state.postModel.description,
                          textAlign: TextAlign.start,
                          style: const TextStyle(fontSize: 13),
                        ),
                        kHeight(10),

                        // ============= Post Image Widget =============
                        PostImageWidget(
                          postModel: state.postModel,
                          height: 420,
                          onDetail: true,
                        ),
                        kHeight(5),

                        // ============= Post Action Buttons =============
                        DetailPostActionBtns(
                          postModel: state.postModel,
                          userModel: widget.currentUser!,
                        ),

                        // ============= Comments View Section
                        CommentAreaWidget(postModel: state.postModel),
                      ],
                    ),
                  ),
                ),

                // ============= Comment Input Field =============
                CommentTextFieldWidget(
                  postModel: state.postModel,
                  onChanged: (p0) {
                    scrollController.jumpTo(
                      scrollController.position.maxScrollExtent,
                    );
                  },
                  onTap: () {
                    scrollController.jumpTo(
                      scrollController.position.maxScrollExtent,
                    );
                  },
                ),
              ],
            );
          }
          return const Center(
            child: Text('Some error'),
          );
        },
      ),
    );
  }
}
