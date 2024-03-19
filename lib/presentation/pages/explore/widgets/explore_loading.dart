import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/theme/light_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          height: 50,
          decoration: BoxDecoration(boxShadow: kBoxShadow),
          margin: const EdgeInsets.fromLTRB(15, 60, 15, 20),
          child: CupertinoSearchTextField(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            backgroundColor: kWhite,
            prefixInsets: const EdgeInsetsDirectional.only(start: 10),
            suffixInsets: const EdgeInsetsDirectional.only(end: 10),
            prefixIcon: const Icon(
              CustomIcons.search_normal_2,
              color: kBlack,
              size: 20,
            ),
            suffixIcon: const Icon(
              Icons.close,
              color: Color(0xFF737373),
            ),
            placeholder: 'Search here...',
            placeholderStyle: TextStyle(
              color: kGray,
              fontSize: 14,
              fontFamily: mainFont,
              fontVariations: fontWeightW500,
              letterSpacing: 0.2,
            ),
            style: TextStyle(
              color: kBlack,
              fontSize: 14,
              fontFamily: mainFont,
              fontVariations: fontWeightW500,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                Text('Suggested People'),
                Spacer(),
                Text(
                  'Show all',
                  style: TextStyle(fontSize: 12, color: kDarkBlue),
                ),
              ],
            ),
          ),
          StaggeredGridView.countBuilder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            shrinkWrap: true,
            crossAxisCount: 2,
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  boxShadow: kBoxShadow,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(radius: 30, backgroundColor: kLightGrey),
                    kHeight(10),
                    const Text('Wiliam Sam'),
                    const Text('@william'),
                    kHeight(10),
                    CustomOutlinedBtn(onPressed: () {}, btnText: 'FOLLOW')
                  ],
                ),
              );
            },
          ),
          const Center(
            child: Text(
              'Explore',
              style: TextStyle(fontSize: 22),
            ),
          ),
          StaggeredGridView.countBuilder(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 30,
            itemBuilder: (context, index) {
              if (index % 2 == 0 || index == 29) {
                return const Tile(
                  height: 220,
                );
              }
              if (index % 3 == 0) {
                return const Tile(height: 150);
              }
              return const Tile(height: 190);
            },
            staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        ],
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.height,
  });

  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: kWhite,
    );
  }
}
