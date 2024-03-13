import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_card.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_card_loading.dart';

class PostSection extends StatefulWidget {
  const PostSection({
    super.key,
  });

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
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
          MultiBlocBuilder(
            blocs: [
              context.watch<PostBloc>(),
              context.watch<ProfileBloc>(),
            ],
            builder: (context, state) {
              var state1 = state[0];
              var state2 = state[1];
              if (state1 is PostInitialState) {
                context.read<PostBloc>().add(PostInitialFetchEvent());
                return Column(
                  children:
                      List.generate(5, (index) => const PostCardLoading()),
                );
              }
              if (state1 is PostDetailFetchingLoadingState) {
                return Column(
                  children:
                      List.generate(5, (index) => const PostCardLoading()),
                );
              }
              if (state1 is PostDetailFetchingSucessState &&
                  state2 is UserDetailFetchingSucessState) {
                return Column(
                  children: List.generate(state1.posts.length, (index) {
                    if (state1.posts[index].isBlocked == false) {
                      return PostCardWidget(
                        postModel: state1.posts[index],
                        userModel: state2.userDetails,
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
