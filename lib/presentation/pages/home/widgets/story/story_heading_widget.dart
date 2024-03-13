import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/presentation/bloc/story/story_bloc.dart';

class StoryHeadingWidget extends StatelessWidget {
  const StoryHeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        children: [
          const Icon(
            CustomIcons.refresh,
            size: 14,
          ),
          kWidth(10),
          const Text(
            'Stories',
            style: TextStyle(fontSize: 15),
          ),
          const Spacer(),
          BlocBuilder<StoryBloc, StoryState>(
            builder: (context, state) {
              if (state is FetchStoriesSuccessState) {
                return Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, border: Border.all(width: 0.5)),
                  child: const Icon(
                    CustomIcons.add,
                    size: 25,
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
