import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/presentation/bloc/profile/profile_bloc.dart';

class UserDetailWidget extends StatelessWidget {
  const UserDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(UserDetailInitialFetchEvent());
    });
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is UserDetailFetchingSucessState) {
          return Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage:
                    NetworkImage(state.userDetails.profilePicture!),
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
                    style: const TextStyle(
                      fontSize: 12,
                      color: kGray,
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
