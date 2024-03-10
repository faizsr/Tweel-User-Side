// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/core/utils/shared_preference.dart';
import 'package:tweel_social_media/data/models/post_model/user_post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    super.key,
    required this.userModel,
    required this.postsList,
  });

  final UserModel userModel;
  final List<UserPostModel> postsList;

  @override
  Widget build(BuildContext context) {
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
                  UserAuthStatus.saveUserStatus(false);
                  nextScreenRemoveUntil(
                    context,
                    const UserSignInPage(),
                  );
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
                  color: Colors.white,
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
                            backgroundImage: NetworkImage(
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
                              _editProfileBtn(context, userModel),
                            ],
                          ),
                        ],
                      ),
                      kHeight(15),
                      const Text('Hey folks 🖐️'),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -40,
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: kWhite,
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 40,
                        color: Colors.black.withOpacity(0.05),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      _userPostFollowCountCard(
                          postsList.length.toString(), 'POSTS'),
                      Container(
                        height: double.infinity,
                        width: 0.5,
                        color: Colors.grey,
                      ),
                      _userPostFollowCountCard(
                          '${userModel.followers!.length}', 'FOLLOWERS'),
                      Container(
                        height: double.infinity,
                        width: 0.5,
                        color: Colors.grey,
                      ),
                      _userPostFollowCountCard(
                          '${userModel.followers!.length}', 'FOLLOWING'),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

SizedBox _userPostFollowCountCard(String count, String title) {
  return SizedBox(
    width: 100,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: const TextStyle(fontSize: 22),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    ),
  );
}

SizedBox _editProfileBtn(BuildContext context, UserModel user) {
  return SizedBox(
    width: 150,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.5),
          borderRadius: BorderRadius.circular(3),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: () {
        nextScreen(context, EditProfilePage(user: user));
      },
      child: const Text(
        'EDIT PROFILE',
        style: TextStyle(
          fontVariations: fontWeightW900,
          color: kBlack,
          fontSize: 11,
        ),
      ),
    ),
  );
}
