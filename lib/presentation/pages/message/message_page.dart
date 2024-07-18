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
import 'package:tweel_social_media/presentation/pages/message/widgets/message_empty_view.dart';
import 'package:tweel_social_media/presentation/pages/message/widgets/message_function.dart';
import 'package:tweel_social_media/presentation/pages/message/widgets/message_listview.dart';
import 'package:tweel_social_media/presentation/pages/message/widgets/message_loading.dart';
import 'package:tweel_social_media/presentation/pages/message/widgets/message_search_view.dart';
import 'package:tweel_social_media/presentation/widgets/refresh_widget.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final SearchController searchController = SearchController();

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    SocketServices().printOnlineUsers();
    context.read<GetChatBloc>().add(FetchAllUserChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return PopScope(
      onPopInvoked: (didPop) {
        searchController.clear();
        context.read<OnSearchMessageCubit>().onSearchChange(false);
      },
      child: ColorfulSafeArea(
        color: theme.surface,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: theme.primaryContainer,
          body: Column(
            children: [
              MessageAppbar(searchController: searchController),
              MultiBlocConsumer(
                buildWhen: null,
                blocs: [
                  context.watch<GetChatBloc>(),
                  context.watch<SearchUserBloc>(),
                  context.watch<OnSearchMessageCubit>(),
                ],
                listener: (context, state) {
                  var chatState = state[0];
                  if (chatState is UserChatsFetchingSuccessState) {
                    // ============ Adding all the previous chats ============
                    context.read<ChatBloc>().add(
                        AddInitialMessageEvent(messageList: chatState.chats));
                  }
                },
                builder: (context, state) {
                  var chatState = state[0];
                  var searchState = state[1];
                  var isSearchState = state[2];
                  if (isSearchState == false) {
                    if (chatState is UserChatsFetchingLoadingState) {
                      return const MessageLoading();
                    }
                    if (chatState is UserChatsFetchingSuccessState) {
                      return MultiBlocBuilder(
                        blocs: [
                          context.watch<ChatBloc>(),
                          context.watch<ProfileBloc>()
                        ],
                        builder: (context, states) {
                          var state1 = states[0];
                          var state2 = states[1];
                          if (state2 is ProfileFetchingSucessState) {
                            if (state1 is ChatAddedState) {
                              // ============ Search Idle View ============
                              UserModel currentUser = state2.userDetails;
        
                              // ============ Sorting users based on last messsage time ============
                              List<UserModel> chatUsersList =
                                  MessageFunctions.sortChatUserList(
                                chatUsersList: chatState.chatUsersList,
                                currentUser: currentUser,
                                messageList: state1.messageList,
                              );
                              return Expanded(
                                child: RefreshWidget(
                                  onRefresh: _handleRefresh,
                                  child: MessageListView(
                                    messagePageController:
                                        messagePageController,
                                    chatUsersList: chatUsersList,
                                    messageList: state1.messageList,
                                    currentUser: currentUser,
                                  ),
                                ),
                              );
                            }
                          }
                          return Container();
                        },
                      );
                    }
                    return Expanded(
                      child: RefreshWidget(
                        onRefresh: _handleRefresh,
                        child: const MessageEmtpyViewWidget(),
                      ),
                    );
                  } else {
                    if (searchState is SearchResultLoadingState) {
                      return const MessageLoading();
                    }
                    if (searchState is SearchResultSuccessState) {
                      return Expanded(
                        child: MessageSearchView(
                          chatUsersList: searchState.users,
                        ),
                      );
                    }
                  }
                  return const Expanded(
                    child: Center(
                      child: Text('No user found'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
