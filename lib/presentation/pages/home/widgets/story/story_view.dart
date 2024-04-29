// ignore_for_file: library_private_types_in_public_api, avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/story_model/story_model.dart';
import 'package:tweel_social_media/presentation/cubit/story_index/story_index_cubit.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({
    super.key,
    required this.imageUrlList,
    required this.dateList,
    required this.story,
  });

  final List<String> imageUrlList;
  final List<String> dateList;
  final StoryModel story;
  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final storyController = StoryController();
  int index = 0;

  @override
  void initState() {
    print(widget.dateList[index]);
    super.initState();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            StoryView(
              inline: false,
              indicatorHeight: IndicatorHeight.medium,
              storyItems: List.generate(
                widget.imageUrlList.length,
                (index) {
                  return StoryItem.pageImage(
                    imageFit: BoxFit.cover,
                    url: widget.imageUrlList[index],
                    controller: storyController,
                  );
                },
              ),
              onStoryShow: (storyItem, index) {
                context.read<StoryIndexCubit>().currentIndex(index);
              },
              onComplete: () {
                Navigator.pop(context);
              },
              onVerticalSwipeComplete: (direction) {
                Navigator.pop(context);
              },
              progressPosition: ProgressPosition.top,
              repeat: false,
              controller: storyController,
            ),
            Positioned.fill(
              top: 25,
              left: 20,
              child: _buildProfileView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(widget.story.user['profile_picture']),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.story.user['username'],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            BlocBuilder<StoryIndexCubit, int>(
              builder: (context, index) {
                print('Index: $index');
                return Text(
                  timeAgo(DateTime.parse(widget.dateList[index])),
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                );
              },
            )
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: Text('Delele story'),
              ),
            );
          },
          icon: Icon(
            Ktweel.more_vert,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ],
    );
  }
}
