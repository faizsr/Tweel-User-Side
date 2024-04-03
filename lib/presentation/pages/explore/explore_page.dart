// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidable/hidable.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:tweel_social_media/data/services/debouncer/debouncer.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/on_search/on_search_cubit.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/custom_search_field.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/explore_post.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/suggested_people.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/user_search_result_view.dart';
import 'package:tweel_social_media/presentation/widgets/refresh_widget.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final Debouncer debouncer =
      Debouncer(delay: const Duration(milliseconds: 300));
  bool isSearchResult = false;

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<UserBloc>().add(FetchAllUserEvent());
    context.read<PostBloc>().add(PostInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshWidget(
      onRefresh: _handleRefresh,
      child: ColorfulSafeArea(
        color: Theme.of(context).colorScheme.surface,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: Hidable(
            preferredWidgetSize: const Size.fromHeight(80),
            controller: scrollController,
            // ============ Search Text Field ============
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: CustomSearchField(
                searchController: searchController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    debouncer.run(() {
                      context
                          .read<SearchUserBloc>()
                          .add(SearchUserEvent(query: value));
                    });
                    context.read<OnSearchCubit>().onSearchChange(true);
                  } else {
                    context.read<OnSearchCubit>().onSearchChange(false);
                  }
                },
              ),
            ),
          ),
          body: MultiBlocBuilder(
            blocs: [
              context.watch<OnSearchCubit>(),
              context.watch<SearchUserBloc>()
            ],
            builder: (context, state) {
              var state1 = state[0];
              var state2 = state[1];
              if (state1 == false) {
                // ============ Explore page ============
                return ListView(
                  children: const [
                    SuggestedPeople(),
                    ExplorePosts(),
                  ],
                );
                // return ExplorePageLoading();
              } else {
                // ============ On Searching ============
                if (state2 is SearchResultLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // ============ Search Result View ============
                if (state2 is SearchResultSuccessState) {
                  return UserSearchResultView(state2: state2);
                }
                // ============ Search No Results ============
                return const Center(
                  child: Text('No User Found'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
