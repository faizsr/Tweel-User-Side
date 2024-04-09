// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_detail_widget.dart';
import 'package:tweel_social_media/presentation/widgets/refresh_widget.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/post_button.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/post_grid_view.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/user_detail_widget.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/user_profile_page_loading.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({
    super.key,
    required this.userId,
    required this.isCurrentUser,
  });

  final String userId;
  final bool isCurrentUser;

  @override
  State<UserProfilePage> createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  @override
  void initState() {
    context.read<UserByIdBloc>().add(FetchUserByIdEvent(userId: widget.userId));
    super.initState();
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<UserByIdBloc>().add(FetchUserByIdEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    changeSystemThemeOnPopup(
      color: Theme.of(context).colorScheme.surface,
      context: context,
    );
    return ColorfulSafeArea(
      color: theme.colorScheme.surface,
      child: RefreshWidget(
        onRefresh: _handleRefresh,
        child: Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: BlocBuilder<UserByIdBloc, UserByIdState>(
            builder: (context, state) {
              if (state is FetchUserByIdLoadingState) {
                return UserProfilePageLoading(
                  isCurrentUser: widget.isCurrentUser,
                  onProfile: false,
                );
              }
              if (state is FetchUserByIdSuccessState) {
                return ListView(
                  children: [
                    widget.isCurrentUser
                        ? ProfileDetailsWidget(
                            postsList: state.posts,
                            userModel: state.userModel,
                            onProfile: false,
                            isCurrentUser: widget.isCurrentUser,
                          )
                        : UserProfileDetailsWidget(
                            userModel: state.userModel,
                            postsList: state.posts,
                            userId: widget.userId,
                          ),
                    kHeight(55),
                    checkAccountType(state),
                  ],
                );
              }
              return const Center(
                child: Text('No data'),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget checkAccountType(FetchUserByIdSuccessState state) {
    if (state.userModel.accountType == 'public') {
      return Column(
        children: [
          if (state.posts.isNotEmpty) const PostButton(),
          kHeight(20),
          PostGridView(state: state),
        ],
      );
    }
    if (state.userModel.accountType == 'private') {
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, userState) {
          List<String> followersId = state.userModel.followers!
              .map((e) => e['_id'].toString())
              .toList();
          List<String> followingId = state.userModel.following!
              .map((e) => e['_id'].toString())
              .toList();
          if (userState is ProfileFetchingSucessState) {
            if (followersId.contains(userState.userDetails.id) &&
                followingId.contains(userState.userDetails.id)) {
              return Column(
                children: [
                  if (state.posts.isNotEmpty) const PostButton(),
                  kHeight(15),
                  PostGridView(state: state),
                ],
              );
            }
          }
          return Column(
            children: [
              kHeight(50),
              Image.asset(
                privateIcon,
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
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              )
            ],
          );
        },
      );
    }
    return Container();
  }
}
