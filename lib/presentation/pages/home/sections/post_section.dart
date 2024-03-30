import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_card.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_card_loading.dart';

class PostSection extends StatelessWidget {
  const PostSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Posts',
            style: TextStyle(fontSize: 16),
          ),
          kHeight(10),
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostInitialState) {
                context.read<PostBloc>().add(PostInitialFetchEvent());
                return Column(
                  children:
                      List.generate(5, (index) => const PostCardLoading()),
                );
              }
              if (state is PostDetailFetchingLoadingState) {
                return Column(
                  children:
                      List.generate(5, (index) => const PostCardLoading()),
                );
              }
              if (state is PostDetailFetchingSucessState) {
                return Column(
                  children: List.generate(state.posts.length, (index) {
                    if (state.posts[index].isBlocked == false) {
                      return PostCardWidget(
                        postModel: state.posts[index],
                        userModel: state.posts[index].user!,
                      );
                    }
                    return Container();
                  }),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
