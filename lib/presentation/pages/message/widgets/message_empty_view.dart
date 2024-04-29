import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
// import 'package:tweel_social_media/presentation/bloc/user/user_bloc.dart';
// import 'package:tweel_social_media/presentation/widgets/user_list_tile.dart';

class MessageEmtpyViewWidget extends StatelessWidget {
  const MessageEmtpyViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: -25.0,
                  child: Icon(
                    Ktweel.message_text,
                    size: 50,
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                kHeight(5),
                const Text(
                  "No Messages, yet.",
                  style: TextStyle(
                    fontSize: 18,
                    fontVariations: fontWeightW600,
                  ),
                ),
                kHeight(5),
                Text(
                  'No messages in your inbox, yet! Start\nchatting with people around you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
                kHeight(5),
                // InkWell(
                //   onTap: () {
                //     // ============= View all users =============
                //     showModalBottomSheet(
                //       backgroundColor:
                //           Theme.of(context).colorScheme.primaryContainer,
                //       context: context,
                //       builder: (context) {
                //         return LayoutBuilder(
                //           builder: (context, constraints) {
                //             return SizedBox(
                //               height: constraints.maxHeight / 1.2,
                //               child: BlocBuilder<UserBloc, UserState>(
                //                 builder: (context, state) {
                //                   if (state is UserDetailFetchingSuccessState) {
                //                     return ListView.builder(
                //                       shrinkWrap: true,
                //                       padding: const EdgeInsets.fromLTRB(
                //                           5, 10, 5, 10),
                //                       itemCount: state.users.length,
                //                       itemBuilder: (context, index) {
                //                         final user = state.users[index];
                //                         return UserListTile(
                //                           onTap: () {},
                //                           profileUrl: user.profilePicture!,
                //                           fullname: user.fullName!,
                //                           username: user.username!,
                //                           buttonText: 'MESSAGE',
                //                         );
                //                       },
                //                     );
                //                   }
                //                   return const Center(
                //                     child: Text('No data'),
                //                   );
                //                 },
                //               ),
                //             );
                //           },
                //         );
                //       },
                //     );
                //   },
                //   child: Text(
                //     'Start a chat?',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       fontSize: 12,
                //       fontVariations: fontWeightW500,
                //       color: theme.colorScheme.onPrimary,
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
