// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/theme.dart';
import 'package:tweel_social_media/core/utils/alerts_and_navigators.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/presentation/bloc/user_by_id/user_by_id_bloc.dart';
import 'package:tweel_social_media/presentation/pages/main/widgets/bottom_nav.dart';
import 'package:tweel_social_media/presentation/pages/user/user_profile_page.dart';

class PostFunctions {
  static onProfileTap({
    required BuildContext context,
    required UserModel userModel,
    required bool onDetail,
  }) {
    return () async {
      var theme = Theme.of(context);
      String currentUserId = await CurrentUserId.getUserId();
      if (currentUserId != userModel.id) {
        debugPrint('Go to profile');
        nextScreen(
            context,
            UserProfilePage(
              userId: userModel.id!,
              isCurrentUser: false,
            )).then((value) {
          mySystemTheme(context);
          if (onDetail) {
            changeSystemThemeOnPopup(
              color: theme.colorScheme.surface,
              context: context,
            );
          }
        });
        context
            .read<UserByIdBloc>()
            .add(FetchUserByIdEvent(userId: userModel.id!));
      } else {
        if (onDetail) {
          debugPrint('On detail');
          nextScreen(
              context,
              UserProfilePage(
                userId: userModel.id!,
                isCurrentUser: true,
              )).then((value) {
            mySystemTheme(context);
            if (onDetail) {
              changeSystemThemeOnPopup(
                color: theme.colorScheme.surface,
                context: context,
              );
            }
          });
          context
              .read<UserByIdBloc>()
              .add(FetchUserByIdEvent(userId: userModel.id!));
        } else {
          indexChangeNotifier.value = 3;
        }
      }
    };
  }
}
