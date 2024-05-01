import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
import 'package:tweel_social_media/presentation/pages/explore/sub_page/all_suggested_user_page.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/explore_loading.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/suggested_grid_view.dart';

class SuggestedPeople extends StatelessWidget {
  const SuggestedPeople({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserInitial) {
          context.read<UserBloc>().add(FetchAllUserEvent());
        }
        if (state is UserDetailFetchingLoadingState) {
          return Column(
            children: [
              suggestedHeading(theme, context),
              const SuggestedPeopleLoading(),
            ],
          );
        }
        if (state is UserDetailFetchingSuccessState) {
          return Column(
            children: [
              suggestedHeading(theme, state: state, context),
              SuggestedPeopleGridView(
                theme: theme,
                state: state,
                maxCount: 4,
                reverse: true,
              ),
            ],
          );
        }
        return const Center(
          child: Text('No data'),
        );
      },
    );
  }

  Padding suggestedHeading(ThemeData theme, BuildContext context,
      {UserDetailFetchingSuccessState? state}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          const Text('Suggested People'),
          const Spacer(),
          InkWell(
            onTap: () {
              if (state != null) {
                nextScreen(
                  context,
                  AllSuggestedUsersPage(state: state),
                );
              }
            },
            child: Text(
              'Show all',
              style:
                  TextStyle(fontSize: 12, color: theme.colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
