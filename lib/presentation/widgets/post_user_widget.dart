import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';
import 'package:tweel_social_media/presentation/widgets/post_more_widget.dart';

class PostUserDetail extends StatelessWidget {
  const PostUserDetail({
    super.key,
    required this.postModel,
    this.userModel,
  });

  final PostModel postModel;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    ThemeData theme = Theme.of(context);
    return Row(
      children: [
        InkWell(
          onTap: () {
            debugPrint('Go to profile');
            nextScreen(context, const UserProfilePage());
            context
                .read<UserByIdBloc>()
                .add(FetchUserByIdEvent(userId: userModel!.id!));
          },
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            backgroundImage: postModel.user!.profilePicture == "" ||
                    userModel!.profilePicture == ""
                ? Image.asset(profilePlaceholder).image
                : NetworkImage(
                    postModel.user!.profilePicture ??
                        userModel!.profilePicture!,
                  ),
          ),
        ),
        kWidth(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postModel.user!.fullName ?? userModel!.fullName!,
              style: const TextStyle(fontSize: 15),
            ),
            kHeight(5),
            SizedBox(
              width: 150,
              child: Text(
                postModel.location,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                filterPostTime(DateTime.parse(
                    postModel.createdDate ?? userModel!.createdAt!)),
                style: TextStyle(
                  fontSize: 11,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is UserDetailFetchingSucessState) {
                  return InkWell(
                    onTap: () {
                      changeSystemThemeOnPopup(
                          color: isDarkMode ? dBottom : lBottom);
                      PostMoreWidget.bottomSheet(
                        context: context,
                        postModel: postModel,
                        userId: state.userDetails.id!,
                        postId: userModel!.id!,
                      );
                    },
                    child: const Icon(Icons.more_vert_sharp),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ],
    );
  }
}
