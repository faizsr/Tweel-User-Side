import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/follow_btn_widget.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/post_follow_count_card.dart';
import 'package:tweel_social_media/presentation/pages/user/widgets/user_heading_widget.dart';
import 'package:tweel_social_media/presentation/widgets/custom_outlined_btn.dart';

class UserProfileDetailsWidget extends StatelessWidget {
  const UserProfileDetailsWidget({
    super.key,
    required this.userModel,
    required this.postsList,
  });

  final UserModel userModel;
  final List<PostModel> postsList;

  @override
  Widget build(BuildContext context) {
    // var brightness = MediaQuery.of(context).platformBrightness;
    // bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        children: [
          UserHeadingWidget(userModel: userModel),
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
                              Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: 80,
                                    child: FollowButton(
                                      userModel: userModel,
                                    ),
                                  ),
                                  kWidth(10),
                                  _messageBtn(),
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
                    if (state is UserDetailFetchingSucessState) {
                      return PostFollowCountWidget(
                        postsList: postsList,
                        userModel: userModel,
                        currentUserModel: state.userDetails,
                        // isFollow: true,
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _messageBtn() {
    return SizedBox(
      height: 35,
      width: 80,
      child: CustomOutlinedBtn(
        onPressed: () {},
        btnText: 'MESSAGE',
      ),
    );
  }
}
