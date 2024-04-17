import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/chat/chat_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/chat_appbar.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/chat_bottom_widget.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/own_message_card.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/reply_card.dart';

class UserChatPage extends StatefulWidget {
  const UserChatPage({
    super.key,
    required this.chatUser,
  });

  final UserModel chatUser;

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return ColorfulSafeArea(
      color: theme.primaryContainer,
      child: Scaffold(
        backgroundColor: theme.surface,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: ChatAppbar(theme: theme, user: widget.chatUser),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, profileState) {
            if (profileState is ProfileFetchingSucessState) {
              return Column(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: BlocBuilder<ChatBloc, ChatState>(
                        builder: (context, state) {
                          if (state is ChatAddedState) {
                            return GroupedListView<ChatModel, DateTime>(
                                elements: state.messageList,
                                padding: const EdgeInsets.all(8),
                                reverse: true,
                                order: GroupedListOrder.DESC,
                                useStickyGroupSeparators: true,
                                floatingHeader: true,
                                groupBy: (message) => DateTime(
                                      message.sendAt.year,
                                      message.sendAt.month,
                                      message.sendAt.day,
                                    ),
                                groupHeaderBuilder: (ChatModel message) {
                                  return SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Card(
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            DateFormat.yMMMd()
                                                .format(message.sendAt),
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemBuilder: (context, ChatModel message) {
                                  final currentUser = profileState.userDetails;

                                  // ============ Send message card ============
                                  if (message.sender.username ==
                                          currentUser.username &&
                                      message.receiver.username ==
                                          widget.chatUser.username) {
                                    return OwnMessageCard(message: message);
                                  }

                                  // ============ Received message card ============
                                  if (message.receiver.username ==
                                          currentUser.username &&
                                      message.sender.username ==
                                          widget.chatUser.username) {
                                    return ReplyCard(message: message);
                                  }
                                  return const SizedBox();
                                });
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                  ChatBottomWidget(
                    theme: theme,
                    chatUser: widget.chatUser,
                    currentUser: profileState.userDetails,
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
