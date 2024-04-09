import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/widgets/loading_skelton.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final SearchController searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primaryContainer,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: theme.colorScheme.onSurface,
                ),
                kWidth(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Skelton(width: 120),
                    kHeight(10),
                    const Skelton(width: 80),
                  ],
                ),
                const Spacer(),
                const Skelton(width: 60),
              ],
            ),
          );
        },
      ),
    );
  }
}
