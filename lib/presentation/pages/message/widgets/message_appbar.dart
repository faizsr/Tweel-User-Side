import 'package:flutter/material.dart';
// import 'package:tweel_social_media/core/utils/constants.dart';
// import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/presentation/pages/explore/widgets/custom_search_field.dart';

class MessageAppbar extends StatelessWidget {
  const MessageAppbar({
    super.key,
    required this.searchController,
  });

  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      color: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              'Messages',
              style: TextStyle(fontSize: 24),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: CustomSearchField(
                    searchController: searchController,
                    onChanged: (value) {},
                  ),
                ),
                // kWidth(10),
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     height: 50,
                //     decoration: BoxDecoration(
                //       color: theme.colorScheme.primaryContainer,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: const Icon(
                //       Ktweel.more_vert_2,
                //       size: 30,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text(
              'All Inbox',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}
