import 'dart:async';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/chat_appbar.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/chat_bottom_widget.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/own_message_card.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/reply_card.dart';

class UserChatPage extends StatefulWidget {
  const UserChatPage({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  late ScrollController scrollController = ScrollController();

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      Timer(const Duration(milliseconds: 100), () => _scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    final theme = Theme.of(context).colorScheme;

    return ColorfulSafeArea(
      color: theme.primaryContainer,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ChatAppbar(theme: theme, user: widget.user),
        ),
        body: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(15),
                  shrinkWrap: true,
                  children: const [
                    OwnMessageCard(),
                    OwnMessageCard(),
                    ReplyCard(),
                    OwnMessageCard(),
                    OwnMessageCard(),
                    OwnMessageCard(),
                    ReplyCard(),
                    OwnMessageCard(),
                    ReplyCard(),
                    ReplyCard(),
                    OwnMessageCard(),
                    OwnMessageCard(),
                    OwnMessageCard(),
                    ReplyCard(),
                    ReplyCard(),
                    OwnMessageCard(),
                    OwnMessageCard(),
                    ReplyCard(),
                  ],
                ),
              ),
            ),
            ChatBottomWidget(
              theme: theme,
              scrollController: scrollController,
            ),
          ],
        ),
      ),
    );
  }
}
