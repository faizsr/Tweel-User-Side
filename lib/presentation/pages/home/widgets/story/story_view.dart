import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/story_model/story_model.dart';

class MoreStories extends StatefulWidget {
  const MoreStories({
    super.key,
    required this.imageUrlList,
    required this.dateList,
    required this.story,
  });

  final List<String> imageUrlList;
  final List<String> dateList;
  final StoryModel story;
  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();
  late String whenCreated;

  @override
  void initState() {
    print(widget.dateList[0]);
    whenCreated = widget.dateList[0];
    super.initState();
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StoryView(
            inline: true,
            storyItems: List.generate(widget.imageUrlList.length, (index) {
              return StoryItem.pageImage(
                imageFit: BoxFit.cover,
                url: widget.imageUrlList[index],
                controller: storyController,
              );
            }),
            onStoryShow: (storyItem, index) {
              // setState(() {
                whenCreated = widget.dateList[index];
              // });
            },
            onComplete: () {
              Navigator.pop(context);
            },
            onVerticalSwipeComplete: (p0) {
              Navigator.pop(context);
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            controller: storyController,
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 80,
              left: 16,
              right: 16,
            ),
            child: _buildProfileView(),
          ),
        ],
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
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.story.user['username'],
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                timeAgo(DateTime.parse(whenCreated)),
                style: const TextStyle(
                  color: Colors.white38,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
