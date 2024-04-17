import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/message/chat_page/user_chat_page.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_menu.dart';
import 'package:tweel_social_media/presentation/pages/report/report_page.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/follow_btn_widget.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/post_follow_count_card.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/user_heading_widget.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class UserProfileDetailsWidget extends StatelessWidget {
  const UserProfileDetailsWidget({
    super.key,
    required this.userModel,
    required this.postsList,
    required this.userId,
  });

  final UserModel userModel;
  final List<PostModel> postsList;
  final String userId;

  void followUnfollowFunction(
      UserModel currentUserModel, UserModel user, bool? isUnfollowing) {
    if (user.followers!.contains(currentUserModel) || isUnfollowing!) {
      userModel.followers!.removeWhere(
        (element) => element['_id'] == currentUserModel.id,
      );
    } else {
      userModel.followers!.add(currentUserModel.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Column(
      children: [
        UserHeadingWidget(
          isCurrentUser: false,
          userModel: userModel,
          onProfile: false,
          onTap: () {
            changeSystemThemeOnPopup(
              color: theme.colorScheme.surfaceTint,
              context: context,
            );
            showDialog(
              context: context,
              builder: (context) {
                return ProfileMenu(
                  leading: const [Ktweel.send, Ktweel.danger, Ktweel.close],
                  profileImage: userModel.profilePicture!,
                  buttonLabel: const [
                    "Sent Message",
                    "Report Account",
                    "Cancel"
                  ],
                  ontap: [
                    () {},
                    () {
                      changeSystemThemeOnPopup(
                        color: theme.colorScheme.surface,
                        context: context,
                      );
                      nextScreen(
                        context,
                        ReportPage(userId: userModel.id!),
                      ).then(
                        (value) => Navigator.pop(context),
                      );
                    },
                    () {
                      Navigator.pop(context);
                    },
                  ],
                );
              },
            ).then((value) => mySystemTheme(context));
          },
        ),
        kHeight(10),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 40,
                      color: Colors.black.withOpacity(0.05),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 0, 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: userModel.profilePicture == ""
                                ? Image.asset(profilePlaceholder).image
                                : NetworkImage(
                                    userModel.profilePicture!,
                                  ),
                          ),
                          kWidth(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userModel.fullName!,
                                style: const TextStyle(fontSize: 17),
                              ),
                              kHeight(5),
                              Text(
                                '${userModel.accountType} profile'.capitalize(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.secondary),
                              ),
                              kHeight(10),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    child: FollowButton(
                                      userModel: userModel,
                                      onFollowUnfollow: followUnfollowFunction,
                                    ),
                                  ),
                                  kWidth(10),
                                  _messageBtn(context, userModel),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      kHeight(15),
                      userModel.bio != '' ? Text(userModel.bio!) : Container(),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileFetchingSucessState) {
                      return PostFollowCountWidget(
                        postsList: postsList,
                        userModel: userModel,
                        userId: userId,
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _messageBtn(BuildContext context, UserModel chatUser) {
    return SizedBox(
      height: 35,
      child: CustomOutlinedBtn(
        onPressed: () {
          nextScreen(
            context,
            UserChatPage(chatUser: chatUser),
          );
        },
        btnText: 'MESSAGE',
      ),
    );
  }
}
