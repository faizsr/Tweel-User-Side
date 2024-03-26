import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/post_button.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/post_grid_view.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/user_detail_widget.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    super.key,
  });

  @override
  State<UserProfilePage> createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<UserByIdBloc, UserByIdState>(
        builder: (context, state) {
          if (state is FetchUserByIdLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FetchUserByIdSuccessState) {
            debugPrint(state.userModel.followers!.length.toString());
            debugPrint(state.userModel.following!.length.toString());
            return ListView(
              children: [
                UserProfileDetailsWidget(
                  userModel: state.userModel,
                  postsList: state.posts,
                ),
                kHeight(50),
                checkAccountType(state),
              ],
            );
          }
          return const Center(
            child: Text('No data'),
          );
        },
      ),
    );
  }

  Widget checkAccountType(FetchUserByIdSuccessState state) {
    if (state.userModel.accountType == 'public') {
      return Column(
        children: [
          const PostButton(),
          kHeight(15),
          PostGridView(state: state),
        ],
      );
    }
    return Column(
      children: [
        kHeight(50),
        Image.asset(
          'assets/images/lock.png',
          width: 80,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        kHeight(10),
        const Text(
          'This account is private',
          style: TextStyle(fontVariations: fontWeightW600, fontSize: 18),
        ),
        kHeight(5),
        Text(
          'Follow this account to see their \nphotos and videos',
          textAlign: TextAlign.center,
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        )
      ],
    );
  }
}
