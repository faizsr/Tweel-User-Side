// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/data/services/socket/socket_services.dart';
import 'package:tweel_social_media/presentation/bloc/chat/chat_bloc.dart';
import 'package:tweel_social_media/presentation/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_menu.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_post_follow_count.dart';
import 'package:tweel_social_media/presentation/pages/settings/settings.dart';
import 'package:tweel_social_media/presentation/pages/settings/sub_pages/about_us_page.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/user_heading_widget.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';
import 'package:tweel_social_media/presentation/widgets/fadein_animate.dart';
import 'package:tweel_social_media/presentation/widgets/profile_circle_widget.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({
    super.key,
    required this.userModel,
    required this.postsList,
    this.onProfile = false,
    required this.isCurrentUser,
  });

  final UserModel userModel;
  final List<PostModel> postsList;
  final bool onProfile;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        UserHeadingWidget(
          isCurrentUser: isCurrentUser,
          userModel: userModel,
          onProfile: onProfile,
          onTap: () {
            debugPrint('dddd');
            FocusScope.of(context).unfocus();
            changeSystemThemeOnPopup(
              context: context,
            );
            _profileMore(
              context,
            ).then((value) {
              mySystemTheme(context);
              FocusScope.of(context).unfocus();
            });
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
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ProfileCircleWidget(
                            radius: 100,
                            imageWidget: userModel.profilePicture == ""
                                ? Image.asset(profilePlaceholder)
                                : FadedImageLoading(
                                    imageUrl: userModel.profilePicture!,
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
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                              kHeight(10),
                              SizedBox(
                                height: 35,
                                width: 150,
                                child: CustomOutlinedBtn(
                                  onPressed: () {
                                    changeSystemThemeOnPopup(
                                      color: theme.colorScheme.surface,
                                      context: context,
                                    );
                                    nextScreen(context,
                                            EditProfilePage(user: userModel))
                                        .then(
                                            (value) => mySystemTheme(context));
                                  },
                                  btnText: 'EDIT PROFILE',
                                ),
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
                child: ProfilePostFollowCountWidget(
                  postsList: postsList,
                  userModel: userModel,
                  isCurrentUser: true,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<dynamic> _profileMore(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return ProfileMenu(
          profileImage: userModel.profilePicture!,
          leading: const [
            Ktweel.settings,
            Ktweel.about,
            Ktweel.logout_2,
          ],
          buttonLabel: const ["Settings", "About Us", "Logout"],
          ontap: [
            () {
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surface,
                context: context,
              );
              nextScreen(
                context,
                SettingsPage(accountType: userModel.accountType!),
              ).then((value) => Navigator.pop(context));
            },
            () {
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surface,
                context: context,
              );
              nextScreen(context, const AboutUsPage()).then(
                (value) => Navigator.pop(context),
              );
            },
            () async {
              UserAuthStatus.saveUserStatus(false);
              SocketServices().disconnectSocket();
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surface,
                context: context,
              );
              context.read<ChatBloc>().add(ClearMessageOnLogoutEvent());
              await nextScreenRemoveUntil(
                context,
                const UserSignInPage(),
              ).then((value) => mySystemTheme(context));
            }
          ],
        );
      },
    );
  }
}
