import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/create_post_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/heading_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kLightWhite,
        toolbarHeight: 0,
      ),
      backgroundColor: kLightWhite,
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              children: [
                const HeadingWidget(),
                kHeight(15),
                const CreatePostCard(),
              ],
            ),
          ),
          const StoryWidget(),
          const PostWidget(),
        ],
      ),
    );
  }
}
