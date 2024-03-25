import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_menu.dart';
import 'package:tweel_social_media/presentation/pages/profile/widgets/profile_post_follow_count.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    super.key,
    required this.userModel,
    required this.postsList,
  });

  final UserModel userModel;
  final List<PostModel> postsList;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                userModel.username!,
                style: const TextStyle(fontVariations: fontWeightW700),
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  changeSystemThemeOnPopup(
                    color: isDarkMode ? dDialog : lDialog,
                  );
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ProfileMenu(
                        profileImage: userModel.profilePicture!,
                      );
                    },
                  ).then((value) => mySystemTheme(context));
                },
                child: const Icon(CustomIcons.setting_2),
              ),
            ],
          ),
          kHeight(10),
          Stack(
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
                                '${userModel.accountType} profile',
                                style: const TextStyle(fontSize: 12),
                              ),
                              kHeight(10),
                              SizedBox(
                                width: 150,
                                child: CustomOutlinedBtn(
                                  height: 40,
                                  width: double.infinity,
                                  onPressed: () {
                                    changeSystemThemeOnPopup(
                                        color: isDarkMode
                                            ? dBlueGrey
                                            : lLightWhite);
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
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
