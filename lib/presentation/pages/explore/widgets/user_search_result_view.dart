import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:tweel_social_media/presentation/widgets/user_list_tile.dart';

class UserSearchResultView extends StatelessWidget {
  const UserSearchResultView({
    super.key,
    required this.state2,
  });

  final SearchResultSuccessState state2;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: state2.users.length,
      itemBuilder: (context, index) {
        return FadeInRight(
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: UserListTile(
              onTap: () {
                context
                    .read<UserByIdBloc>()
                    .add(FetchUserByIdEvent(userId: state2.users[index].id!));
                changeSystemThemeOnPopup(
                  color: Theme.of(context).colorScheme.surface,
                  context: context,
                );
                nextScreen(
                  context,
                  UserProfilePage(
                    userId: state2.users[index].id!,
                    isCurrentUser: false,
                  ),
                ).then((value) => mySystemTheme(context));
              },
              profileUrl: state2.users[index].profilePicture!,
              fullname: state2.users[index].fullName!,
              username: state2.users[index].username!,
            ),
          ),
        );
      },
    );
  }
}
