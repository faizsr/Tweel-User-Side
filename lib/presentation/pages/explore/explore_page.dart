import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/custom_search_field.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/explore_post.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/suggested_people.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: kLightWhite,
      child: Scaffold(
        backgroundColor: kLightWhite,
        appBar: Hidable(
          preferredWidgetSize: const Size.fromHeight(80),
          controller: scrollController,
          child: const CustomSearchField(),
        ),
        body: ListView(
          controller: scrollController,
          children: const [
            SuggestedPeople(),
            ExplorePosts(),
          ],
        ),
      ),
    );
  }
}
