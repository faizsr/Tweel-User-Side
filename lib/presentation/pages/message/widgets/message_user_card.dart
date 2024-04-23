import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/online_users/online_users_cubit.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/user_chat_page.dart';

class MessageUserCard extends StatefulWidget {
  const MessageUserCard({
    super.key,
    required this.chatUser,
    this.lastMessage,
  });

  final UserModel chatUser;
  final ChatModel? lastMessage;

  @override
  State<MessageUserCard> createState() => _MessageUserCardState();
}

class _MessageUserCardState extends State<MessageUserCard> {
  bool isOwnMessage = false;
  bool isReplyMessage = false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileFetchingSucessState) {
          isOwnMessage =
              isOwnMessageFn(widget.lastMessage!, profileState.userDetails);
          isReplyMessage =
              isReplyMessageFn(widget.lastMessage!, profileState.userDetails);
          String lastMessgeTime = isToday(widget.lastMessage!.sendAt)
              ? formatTime(widget.lastMessage!.sendAt.toLocal())
              : isYesterday(widget.lastMessage!.sendAt)
                  ? 'Yesterday'
                  : DateFormat.yMd().format(widget.lastMessage!.sendAt);

          return InkWell(
            onTap: () {
              nextScreen(
                context,
                UserChatPage(chatUser: widget.chatUser),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 12),
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: theme.colorScheme.onSurface,
                        backgroundImage: widget.chatUser.profilePicture == ""
                            ? Image.asset(profilePlaceholder).image
                            : NetworkImage(widget.chatUser.profilePicture!),
                      ),
                      BlocBuilder<OnlineUsersCubit, List<String>>(
                        builder: (context, state) {
                          return state.contains(widget.chatUser.username)
                              ? const Positioned(
                                  bottom: 4,
                                  right: 2,
                                  child: CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.green,
                                  ),
                                )
                              : const SizedBox();
                        },
                      ),
                    ],
                  ),
                  kWidth(15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatUser.fullName!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      kHeight(5),
                      if (isOwnMessage)
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 250,
                          child: Text(
                            widget.lastMessage!.message,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      if (isReplyMessage)
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 250,
                          child: Text(
                            widget.lastMessage!.message,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  if (isOwnMessage)
                    Text(
                      lastMessgeTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  if (isReplyMessage)
                    Text(
                      lastMessgeTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  bool isOwnMessageFn(ChatModel message, UserModel currentUser) {
    return message.sender.username == currentUser.username &&
        message.receiver.username == widget.chatUser.username;
  }

  bool isReplyMessageFn(ChatModel message, UserModel currentUser) {
    return message.receiver.username == currentUser.username &&
        message.sender.username == widget.chatUser.username;
  }
}
