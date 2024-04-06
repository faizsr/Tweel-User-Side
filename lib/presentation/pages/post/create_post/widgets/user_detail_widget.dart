import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';

class UserDetailWidget extends StatelessWidget {
  const UserDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileFetchingSucessState) {
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: state.userDetails.profilePicture == ""
                    ? Image.asset(profilePlaceholder).image
                    : NetworkImage(state.userDetails.profilePicture!),
              ),
              kWidth(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.userDetails.fullName!,
                    style: const TextStyle(
                      fontVariations: fontWeightW600,
                      fontSize: 15,
                    ),
                  ),
                  kHeight(5),
                  Text(
                    state.userDetails.accountType!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              )
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}
