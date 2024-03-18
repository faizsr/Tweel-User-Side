import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/custom_icons_icons.dart';
import 'package:tweel_social_media/core/utils/shared_preference.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/pages/profile/edit_profile/edit_profile_page.dart';
import 'package:tweel_social_media/presentation/pages/profile/followers_list/followers_list_page.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';
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
                              SizedBox(
                                width: 150,
                                child: CustomOutlinedBtn(
                                  onPressed: () {
                                    nextScreen(context,
                                        EditProfilePage(user: userModel));
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
                        count: postsList.length.toString(),
                        title: 'POSTS',
                        onTap: () {},
                      ),
                      Container(
                        height: double.infinity,
                        width: 0.5,
                        color: Colors.grey,
                      ),
                      _userPostFollowCountCard(
                        count: '${userModel.followers!.length}',
                        title: 'FOLLOWERS',
                        onTap: () {
                          nextScreen(
                            context,
                            const FollowerListPage(selectedPage: 0),
                          );
                        },
                      ),
                      Container(
                        height: double.infinity,
                        width: 0.5,
                        color: Colors.grey,
                      ),
                      _userPostFollowCountCard(
                        count: '${userModel.followers!.length}',
                        title: 'FOLLOWING',
                        onTap: () {
                          nextScreen(
                            context,
                            const FollowerListPage(selectedPage: 1),
                          );
                        },
                      ),
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

Widget _userPostFollowCountCard(
    {required String count, required String title, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: kWhite,
      ),
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
    ),
  );
}
