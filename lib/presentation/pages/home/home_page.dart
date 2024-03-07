import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/sections/create_post_card.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/heading_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/sections/post_section.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/sections/story_section.dart';

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
          const PostSection(),
        ],
      ),
    );
  }
}
