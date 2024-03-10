import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is UserDetailFetchingLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserDetailFetchingSucessState) {
            return ListView(
              children: [
                UserDetailsWidget(
                  userModel: state.userDetails,
                  postsList: state.posts,
                ),
                kHeight(60),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.posts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(state.posts[index].mediaURL[0]),
                        fit: BoxFit.cover,
                      )),
                    );
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
}
