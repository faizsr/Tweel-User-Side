import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/story/story_bloc.dart';
import 'package:tweel_social_media/presentation/pages/post/create_post/media_picker/media_picker_page.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class StoryHeadingWidget extends StatefulWidget {
  const StoryHeadingWidget({
    super.key,
  });

  @override
  State<StoryHeadingWidget> createState() => _StoryHeadingWidgetState();
}

class _StoryHeadingWidgetState extends State<StoryHeadingWidget> {
  String userId = '';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Row(
        children: [
          const Icon(
            Ktweel.status,
            size: 16,
          ),
          kWidth(5),
          const Text(
            'Stories',
            style: TextStyle(fontSize: 15),
          ),
          const Spacer(),
          MultiBlocBuilder(
            blocs: [context.watch<StoryBloc>(), context.watch<ProfileBloc>()],
            builder: (context, state) {
              var state1 = state[0];
              var state2 = state[1];
              if (state2 is UserDetailFetchingSucessState) {
                userId = state2.userDetails.id!;
              }
              if (state1 is FetchStoriesSuccessState) {
                return GestureDetector(
                  onTap: () {
                    nextScreen(
                      context,
                      MediaPicker(
                        maxCount: 1,
                        requestType: RequestType.image,
                        screenType: ScreenType.story,
                        userId: userId,
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    child: Icon(
                      Ktweel.add,
                      size: 22,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
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
