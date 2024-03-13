import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post_detail/post_detail_page.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/user_detail_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightWhite,
      body: MultiBlocBuilder(
        blocs: [context.watch<PostBloc>(), context.watch<ProfileBloc>()],
        builder: (context, state) {
          var postState = state[0];
          var profileState = state[1];
          if (postState is RemovePostSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
          }
          if (profileState is UserDetailFetchingLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (profileState is UserDetailFetchingSucessState) {
            return ListView(
              children: [
                UserDetailsWidget(
                  userModel: profileState.userDetails,
                  postsList: profileState.posts,
                ),
                kHeight(50),
                const Center(
                  child: Text(
                    'Posts',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                kHeight(10),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profileState.posts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    if (profileState.posts[index].isBlocked == false) {
                      return InkWell(
                        onTap: () {
                          nextScreen(
                            context,
                            PostDetailPage(
                              postModel: profileState.posts[index],
                              userModel: profileState.userDetails,
                            ),
                          );
                        },
                        child: postImageCard(profileState, index),
                      );
                    }
                    return Container();
                  },
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  Container postImageCard(UserDetailFetchingSucessState state, int index) {
    return Container(
      margin: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(state.posts[index].mediaURL![0]),
        fit: BoxFit.cover,
      )),
    );
  }
}
