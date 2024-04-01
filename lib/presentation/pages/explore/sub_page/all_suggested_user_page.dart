import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/suggested_grid_view.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar_2.dart';

class AllSuggestedUsersPage extends StatelessWidget {
  const AllSuggestedUsersPage({
    super.key,
    required this.state,
    required this.theme,
  });

  final ThemeData theme;
  final UserDetailFetchingSuccessState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppbar2(
          title: 'Suggested for you',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SuggestedPeopleGridView(theme: theme, state: state),
    );
  }
}
