// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/presentation/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_menu.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_post_follow_count.dart';
import 'package:tweel_social_media/presentation/pages/settings/settings.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/user_heading_widget.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

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
    return Column(
      children: [
        UserHeadingWidget(
          isCurrentUser: isCurrentUser,
          userModel: userModel,
          onProfile: onProfile,
          onTap: () {
            changeSystemThemeOnPopup(
              color: Theme.of(context).colorScheme.surfaceTint,
              context: context,
            );
            _profileMore(
              context,
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
                  color: Theme.of(context).colorScheme.primaryContainer,
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
                                style: const TextStyle(fontSize: 12),
                              ),
                              kHeight(10),
                              SizedBox(
                                height: 35,
                                width: 150,
                                child: CustomOutlinedBtn(
                                  onPressed: () {
                                    changeSystemThemeOnPopup(
                                      color:
                                          Theme.of(context).colorScheme.surface,
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
            () async {
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surface,
                context: context,
              );
              await nextScreen(
                context,
                SettingsPage(accountType: userModel.accountType!),
              ).then((value) {
                Navigator.pop(context);
              });
            },
            () {},
            () async {
              UserAuthStatus.saveUserStatus(false);
              changeSystemThemeOnPopup(
                color: Theme.of(context).colorScheme.surface,
                context: context,
              );
              await nextScreenRemoveUntil(
                context,
                const UserSignInPage(),
              );
              mySystemTheme(context);
            }
          ],
        );
      },
    );
  }
}
