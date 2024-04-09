import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).colorScheme;
    return ColorfulSafeArea(
      color: theme.surface,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: theme.primaryContainer,
          body: Column(
            children: [
              MessageAppbar(searchController: searchController),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserDetailFetchingSuccessState) {
                    return Expanded(
                      child: ListView.builder(
                        controller: messagePageController,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        itemCount: state.users.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          UserModel user = state.users[index];
                          return MessageUserCard(user: user);
                        },
                      ),
                    );
                  }
                  return const Center(
                    child: Text('No Users'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
