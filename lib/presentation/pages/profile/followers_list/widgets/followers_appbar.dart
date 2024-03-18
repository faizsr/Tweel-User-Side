import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/light_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';

class FollowersAppbar extends StatelessWidget {
  const FollowersAppbar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Connections',
        style: TextStyle(fontSize: 20),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          CustomIcons.arrow_left,
          size: 25,
        ),
      ),
      actions: const [
        AnimatedSearchBar(),
      ],
      bottom: TabBar(
        indicatorSize: TabBarIndicatorSize.label,
        indicator: UnderlineTabIndicator(
          borderSide: const BorderSide(width: 2, color: kDarkBlue),
          insets: const EdgeInsets.symmetric(horizontal: 16.0),
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorPadding: const EdgeInsets.all(0),
        splashFactory: NoSplash.splashFactory,
        labelColor: kDarkBlue,
        labelPadding: const EdgeInsets.all(0),
        unselectedLabelColor: kBlack,
        labelStyle: TextStyle(
          fontFamily: mainFont,
          fontSize: 12,
          fontVariations: fontWeightW500,
        ),
        tabs: const [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Tab(text: 'FOLLOWERS', height: 25),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Tab(text: 'FOLLOWING', height: 25),
          ),
        ],
      ),
    );
  }
}

class AnimatedSearchBar extends StatefulWidget {
  const AnimatedSearchBar({super.key});

  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> {
  bool _isSearchActive = false;
  final _focusNode = FocusNode();

  void _toggleSearch() {
    setState(() {
      _isSearchActive = !_isSearchActive;
    });
    if (!_isSearchActive) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSearch,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInQuad,
            width: _isSearchActive ? 300 : 40,
            height: 40,
            child: _isSearchActive
                ? Expanded(
                    child: TextField(
                      textAlign: TextAlign.start,
                      autofocus: true,
                      focusNode: _focusNode,
                      style: const TextStyle(color: kBlack),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 10),
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(color: kGray, fontSize: 16),
                      ),
                    ),
                  )
                : Container(),
          ),
          _isSearchActive
              ? const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(Icons.close, color: kBlack),
                )
              : const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(CustomIcons.search_normal_2, color: kBlack),
                ),
        ],
      ),
    );
  }
}
