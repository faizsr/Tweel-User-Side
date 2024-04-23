import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/chat/chat_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/chat_appbar.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/chat_bottom_widget.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/chat_empty_view.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/widgets/chat_view.dart';

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
                            final currentUser = profileState.userDetails;
                            bool hasMessages = _hasMessages(
                              currentUser.username!,
                              widget.chatUser.username!,
                              state.messageList,
                            );
                            if (!hasMessages) {
                              // ============= Chat Empty View =============
                              return const ChatEmptyView();
                            } else {
                              // ============= Chat View =============
                              return ChatView(
                                messageList: state.messageList,
                                currentUser: currentUser,
                                chatUser: widget.chatUser,
                              );
                            }
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),

                  // ============= Message Input Field =============
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

  bool _hasMessages(
      String currentUser, String otherUser, List<ChatModel> messages) {
    return messages.any((message) =>
        (message.sender.username == currentUser &&
            message.receiver.username == otherUser) ||
        (message.receiver.username == currentUser &&
            message.sender.username == otherUser));
  }
}
