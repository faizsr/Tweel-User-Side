import 'package:flutter/material.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/suggested_grid_view.dart';
import 'package:tweel_social_media/presentation/widgets/custom_appbar_2.dart';

class AllSuggestedUsersPage extends StatelessWidget {
  const AllSuggestedUsersPage({
    super.key,
    required this.state,
  });

  final UserDetailFetchingSuccessState state;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: CustomAppbar2(
          backgroundColor: theme.colorScheme.surface,
          title: 'Suggested for you',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SuggestedPeopleGridView(theme: theme, state: state,isDetail: true,),
    );
  }
}
