import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/ktweel_icons.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/presentation/cubit/online_users/online_users_cubit.dart';

class ChatAppbar extends StatelessWidget {
  const ChatAppbar({
    super.key,
    required this.theme,
    required this.user,
  });

  final ColorScheme theme;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.primaryContainer,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Ktweel.arrow_left_ios),
          ),
          CircleAvatar(
            backgroundImage: user.profilePicture == ""
                ? Image.asset(profilePlaceholder).image
                : NetworkImage(user.profilePicture!),
          ),
          kWidth(15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullName!,
                style: const TextStyle(fontSize: 15),
              ),
              kHeight(2),
              BlocBuilder<OnlineUsersCubit, List<String>>(
                builder: (context, state) {
                  return state.contains(user.username)
                      ? Text(
                          'Active now',
                          style: TextStyle(
                            color: theme.secondary,
                            fontSize: 12,
                          ),
                        )
                      : const SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
