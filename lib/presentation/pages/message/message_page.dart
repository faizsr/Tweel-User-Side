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
import 'package:tweel_social_media/presentation/widgets/refresh_widget.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final SearchController searchController = SearchController();
  final messageScrollController = ScrollController();
  String currentUsername = '';

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<GetChatBloc>().add(FetchAllUserChatsEvent());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFetchingSucessState) {
          // ============= Connection user to the socket io server =============
          currentUsername = state.userDetails.username!;
          UserModel currentUser = state.userDetails;
          SocketServices().connectSocket(
            currentUser.username ?? '',
            context,
            messageScrollController,
          );
        }
      },
      child: ColorfulSafeArea(
        color: theme.surface,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: PopScope(
            onPopInvoked: (didPop) {
              searchController.clear();
              context.read<OnSearchMessageCubit>().onSearchChange(false);
            },
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
                          context.read<ChatBloc>().add(
                              AddNewMessageEvent(chatModel: state.chats[i]));
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is UserChatsFetchingLoadingState) {
                        return const MessageLoading();
                      }
                      if (state is UserChatsFetchingSuccessState) {
                        return MultiBlocBuilder(
                          blocs: [
                            context.watch<OnSearchMessageCubit>(),
                            context.watch<SearchUserBloc>(),
                            context.watch<ChatBloc>(),
                            context.watch<ProfileBloc>()
                          ],
                          builder: (context, states) {
                            var state1 = states[0];
                            var state2 = states[1];
                            var state3 = states[2];
                            var state4 = states[3];

                            if (state4 is ProfileFetchingSucessState) {
                              if (state3 is ChatAddedState) {
                                // ============ Search Idle View ============
                                if (state1 == false) {
                                  UserModel currentUser = state4.userDetails;

                                  // ============ Sorting users based on last messsage time ============
                                  List<UserModel> chatUsersList =
                                      MessageFunctions.sortChatUserList(
                                    chatUsersList: state.chatUsersList,
                                    currentUser: currentUser,
                                    messageList: state3.messageList,
                                  );
                                  return Expanded(
                                    child: RefreshWidget(
                                      onRefresh: _handleRefresh,
                                      child: MessageListView(
                                        messagePageController:
                                            messagePageController,
                                        chatUsersList: chatUsersList,
                                        messageList: state3.messageList,
                                        currentUser: currentUser,
                                      ),
                                    ),
                                  );
                                } else {
                                  // ============ On Searching ============
                                  if (state2 is SearchResultLoadingState) {
                                    return const MessageLoading();
                                  }
                                  // ============ Search Result View ============
                                  if (state2 is SearchResultSuccessState) {
                                    UserModel currentUser = state4.userDetails;
                                    return Expanded(
                                      child: MessageListView(
                                        messagePageController:
                                            messagePageController,
                                        chatUsersList: state2.users,
                                        messageList: state3.messageList,
                                        currentUser: currentUser,
                                      ),
                                    );
                                  }
                                  // ============ Search No Results ============
                                  return const Expanded(
                                    child: Center(
                                      child: Text('User Not Found!'),
                                    ),
                                  );
                                }
                              }
                            }
                            return Container();
                          },
                        );
                      }
                      return const Expanded(
                        child: MessageEmtpyViewWidget(),
                      );
                    },
                  ),
                ],
              ),
            ),
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
