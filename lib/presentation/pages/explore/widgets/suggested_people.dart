import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class SuggestedPeople extends StatelessWidget {
  const SuggestedPeople({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Text('Suggested People'),
              Spacer(),
              Text(
                'Show all',
                style: TextStyle(fontSize: 12, color: theme.colorScheme.onPrimary),
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
                color: theme.colorScheme.primaryContainer,
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
      ],
    );
  }
}
