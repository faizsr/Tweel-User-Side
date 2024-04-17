// ignore_for_file: use_build_context_synchronously

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/data/services/socket/socket_services.dart';
import 'package:tweel_social_media/presentation/bloc/chat/chat_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/get_chat/get_chat_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/search_user/search_user_bloc.dart';
import 'package:tweel_social_media/presentation/cubit/on_search_message/on_search_cubit.dart';
import 'package:tweel_social_media/presentation/pages/main/widgets/bottom_nav.dart';
import 'package:tweel_social_media/presentation/pages/message/widgets/message_appbar.dart';
import 'package:tweel_social_media/presentation/pages/message/widgets/message_user_card.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final SearchController searchController = SearchController();
  final messageScrollController = ScrollController();
  // String currentUsername = '';

  // Future<void> _handleRefresh() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   context
  //       .read<GetChatBloc>()
  //       .add(FetchAllUserChatsEvent(currentUsername: currentUsername));
  // }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFetchingSucessState) {
          // currentUsername = state.userDetails.username ?? '';
          // ============= Connection user to the socket io server =============
          String currentUser = state.userDetails.username ?? '';
          SocketServices().connectSocket(
            currentUser,
            context,
            messageScrollController,
          );
        }
      },
      child: ColorfulSafeArea(
        color: theme.surface,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: theme.primaryContainer,
            body: Column(
              children: [
                MessageAppbar(searchController: searchController),
                BlocConsumer<GetChatBloc, GetChatState>(
                  listener: (context, state) {
                    if (state is UserChatsFetchingSuccessState) {
                      // ============ Adding all the previous chats ============
                      for (int i = 0; i < state.chats.length; i++) {
                        context
                            .read<ChatBloc>()
                            .add(AddNewMessageEvent(chatModel: state.chats[i]));
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is UserChatsFetchingLoadingState) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is UserChatsFetchingSuccessState) {
                      return MultiBlocBuilder(
                        blocs: [
                          context.watch<OnSearchMessageCubit>(),
                          context.watch<SearchUserBloc>(),
                        ],
                        builder: (context, states) {
                          var state1 = states[0];
                          var state2 = states[1];
                          if (state1 == false) {
                            return Expanded(
                              child: ListView.builder(
                                controller: messagePageController,
                                padding:
                                    const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                itemCount: state.chatUsersList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  UserModel chatUser =
                                      state.chatUsersList[index];
                                  return MessageUserCard(chatUser: chatUser);
                                },
                              ),
                            );
                          } else {
                            // ============ On Searching ============
                            if (state2 is SearchResultLoadingState) {
                              return const Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            // ============ Search Result View ============
                            if (state2 is SearchResultSuccessState) {
                              return Expanded(
                                child: ListView.builder(
                                  controller: messagePageController,
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  itemCount: state2.users.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    UserModel chatUser = state2.users[index];
                                    return MessageUserCard(chatUser: chatUser);
                                  },
                                ),
                              );
                            }
                            // ============ Search No Results ============
                            return const Expanded(
                              child: Center(
                                child: Text('No User Found'),
                              ),
                            );
                          }
                        },
                      );
                    }
                    return const Expanded(
                      child: Center(
                        child: Text("You haven't started messaging."),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
