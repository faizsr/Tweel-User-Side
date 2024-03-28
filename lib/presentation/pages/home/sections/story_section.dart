import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/story_model/story_model.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/story/story_bloc.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_card.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_heading_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_utils.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_view.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 0, 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        boxShadow: kBoxShadow,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StoryHeadingWidget(),
          kHeight(15),
          _stoiesListview(context),
        ],
      ),
    );
  }

  Widget _stoiesListview(BuildContext context) {
    String userId = '';
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is UserDetailFetchingSucessState) {
              userId = state.userDetails.id!;
              debugPrint('Story Success User Id: $userId');
            }
          },
          child: BlocConsumer<StoryBloc, StoryState>(
            listener: (context, state) {
              if (state is AddStorySucessState) {
                Navigator.of(context).pop();
                context.read<StoryBloc>().add(FetchAllStoriesEvent());
              }
            },
            builder: (context, state) {
              if (state is StoryInitialState) {
                context.read<StoryBloc>().add(FetchAllStoriesEvent());
              }
              if (state is FetchStoriesLoadingState) {
                return Row(
                  children: List.generate(
                      10, (index) => StoryUtils.loadingStoryCard()),
                );
              }
              if (state is FetchStoriesSuccessState) {
                Map<String, List<StoryModel>> userStories =
                    eachUserStory(state.storiesList);
                debugPrint('Stories Length: ${userStories.length}');
                List<Widget> storyCards = [];
                userStories.forEach((userId, stories) {
                  if (stories.length > 1) {
                    List<String> images = [];
                    List<String> createdDates = [];
                    for (var story in stories) {
                      images.add(story.image);
                      createdDates.add(story.createdDate);
                    }
                    storyCards.add(
                      GestureDetector(
                        onTap: () {
                          // Handle onTap
                          changeSystemThemeOnPopup(color: lBlack);
                          nextScreen(
                            context,
                            MoreStories(
                              imageUrlList: images,
                              dateList: createdDates,
                              story: stories.first,
                            ),
                          ).then((value) => mySystemTheme(context));
                        },
                        child: StoryCard(
                          storyModel: stories.first, // Show first story
                        ),
                      ),
                    );
                  } else {
                    storyCards.add(
                      GestureDetector(
                        onTap: () {
                          changeSystemThemeOnPopup(color: lBlack);
                          nextScreen(
                            context,
                            MoreStories(
                              imageUrlList: [stories.first.image],
                              dateList: [stories.first.createdDate],
                              story: stories.first,
                            ),
                          ).then((value) => mySystemTheme(context));
                        },
                        child: StoryCard(storyModel: stories.first),
                      ),
                    );
                  }
                });
                return Row(
                  children: storyCards,
                );
              }
              return StoryUtils.emptyStoryView(context, userId);
            },
          ),
        ),
      ),
    );
  }

  Map<String, List<StoryModel>> eachUserStory(List<StoryModel> storiesList) {
    Map<String, List<StoryModel>> userStories = {};
    for (var story in storiesList) {
      String userId = story.user['_id'];
      if (!userStories.containsKey(userId)) {
        userStories[userId] = [];
      }
      userStories[userId]!.add(story);
    }
    return userStories;
  }
}
