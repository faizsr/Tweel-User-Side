// ignore_for_file: deprecated_member_use

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/data/services/socket/socket_services.dart';

class ChatBottomWidget extends StatefulWidget {
  const ChatBottomWidget({
    super.key,
    required this.theme,
    required this.currentUser,
    required this.chatUser,
  });

  final ColorScheme theme;
  final UserModel currentUser;
  final UserModel chatUser;

  @override
  State<ChatBottomWidget> createState() => _ChatBottomWidgetState();
}

class _ChatBottomWidgetState extends State<ChatBottomWidget> {
  bool show = false;
  bool sendButton = false;
  FocusNode focusNode = FocusNode();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (show) {
          setState(() {
            show = false;
          });
        } else {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: widget.theme.primaryContainer,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      focusNode.unfocus();
                      focusNode.canRequestFocus = false;
                      setState(() {
                        show = !show;
                      });
                    },
                    icon: Icon(
                      Icons.emoji_emotions_outlined,
                      color: widget.theme.secondary,
                      size: 26,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          sendButton = true;
                        });
                      }
                    },
                    controller: messageController,
                    focusNode: focusNode,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type here...',
                      hintStyle: TextStyle(
                        color: widget.theme.secondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                kWidth(5),
                Expanded(
                  flex: 1,
                  child: sendButton
                      ? IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: widget.theme.onPrimary,
                            shape: const CircleBorder(),
                          ),
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              // ============ Send message function ============
                              SocketServices().sendMessage(
                                message: messageController.text,
                                currentUser: widget.currentUser,
                                chatUser: widget.chatUser,
                                context: context,
                              );
                              messageController.clear();
                              setState(() {
                                sendButton = false;
                              });
                            }
                          },
                          icon: Icon(
                            Ktweel.send_2,
                            color: widget.theme.primaryContainer,
                            size: 20,
                          ),
                        )
                      : const SizedBox(),
                )
              ],
            ),
          ),
          show ? emojiWidget() : Container(),
        ],
      ),
    );
  }

  Widget emojiWidget() {
    return EmojiPicker(
      config: Config(
        categoryViewConfig: CategoryViewConfig(
          tabBarHeight: 40,
          tabIndicatorAnimDuration: const Duration(milliseconds: 500),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
        bottomActionBarConfig: const BottomActionBarConfig(
          showBackspaceButton: false,
          showSearchViewButton: false,
        ),
        emojiViewConfig: EmojiViewConfig(
          columns: 8,
          emojiSizeMax: 25,
          backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          noRecents: Text(
            'No Recents',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
      ),
      onEmojiSelected: (category, emoji) {
        setState(() {
          messageController.text = messageController.text + emoji.emoji;
        });
      },
    );
  }
}
