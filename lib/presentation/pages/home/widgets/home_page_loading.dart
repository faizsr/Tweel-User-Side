import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/heading_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/create_post_card_loading.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/post/post_card_loading.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_heading_widget.dart';
import 'package:tweel_social_media/presentation/pages/home/widgets/story/story_utils.dart';

class HomePageLoading extends StatelessWidget {
  const HomePageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    mySystemTheme(context);
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
            child: Column(
              children: [
                const HeadingWidget(),
                kHeight(15),
                const CreatePostCardLoading(),
              ],
            ),
          ),
          Container(
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding:
                        const EdgeInsets.fromLTRB(10, 0, 10, 15),
                    child: Row(
                      children: List.generate(
                        10,
                        (index) => StoryUtils.loadingStoryCard(context),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  'Recent Posts',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
                child: PostCardLoading(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
