import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/story/story_bloc.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_card.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_heading_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_utils.dart';

class StoryWidget extends StatelessWidget {
  const StoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 0, 0, 20),
      decoration: BoxDecoration(
        color: kWhite,
        boxShadow: kBoxShadow,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [const StoryHeadingWidget(), kHeight(15), _stoiesListview()],
      ),
    );
  }

  Widget _stoiesListview() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        child: BlocBuilder<StoryBloc, StoryState>(
          builder: (context, state) {
            if (state is StoryInitialState) {
              context.read<StoryBloc>().add(FetchAllStoriesEvent());
            }
            if (state is FetchStoriesLoadingState) {
              return Row(
                children:
                    List.generate(10, (index) => StoryUtils.loadingStoryCard()),
              );
            }
            if (state is FetchStoriesSuccessState) {
              return Row(
                children: List.generate(state.storiesList.length, (index) {
                  return StoryCard(storyModel: state.storiesList[index]);
                }),
              );
            }
            return StoryUtils.emptyStoryView();
          },
        ),
      ),
    );
  }
}
