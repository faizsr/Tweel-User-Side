// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/post/post_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/story/story_bloc.dart';
import 'package:tweel_social_media/presentation/widgets/refresh_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/sections/create_post_card.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/heading_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/sections/post_section.dart';
import 'package:tweel_social_media/presentation/pages/home/sections/story_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> handleRefresh() async {
      await Future.delayed(const Duration(seconds: 2));
      context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
      context.read<StoryBloc>().add(FetchAllStoriesEvent());
      context.read<PostBloc>().add(PostInitialFetchEvent());
    }

    mySystemTheme(context);
    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.surface,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: RefreshWidget(
          onRefresh: handleRefresh,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                child: Column(
                  children: [
                    const HeadingWidget(),
                    kHeight(15),
                    const CreatePostCard(),
                  ],
                ),
              ),
              const StoryWidget(),
              const PostSection(),
            ],
          ),
        ),
      ),
    );
  }
}
