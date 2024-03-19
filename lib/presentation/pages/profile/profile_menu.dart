import 'dart:ui';

import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tweel_social_media/core/theme/light_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';
import 'package:tweel_social_media/core/utils/shared_preference.dart';
import 'package:tweel_social_media/presentation/pages/user_signin/user_signin_page.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({
    super.key,
    required this.profileImage,
  });

  final String profileImage;

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.profileImage),
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 200))
                  .scale(begin: const Offset(.8, .8), curve: Curves.easeOut),
              kHeight(20),
              _buildBottomBtns(context),
              kHeight(50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBtns(BuildContext context) {
    return SeparatedColumn(
      separatorBuilder: () =>
          const Divider(thickness: 1.5, height: 1).animate().scale(
                duration: const Duration(milliseconds: 800),
                delay: const Duration(microseconds: 500),
                curve: Curves.easeOutBack,
              ),
      children: [
        _MenuTextBtn(
          label: 'Settings',
          onTap: () {},
        ),
        _MenuTextBtn(
          label: 'Logout',
          onTap: () {
            UserAuthStatus.saveUserStatus(false);
            nextScreenRemoveUntil(
              context,
              const UserSignInPage(),
            );
            mySystemTheme();
          },
        ),
        _MenuTextBtn(
          label: 'About us',
          onTap: () {},
        ),
      ]
          .animate(interval: 50.ms)
          .fade(delay: const Duration(milliseconds: 100))
          .slide(begin: const Offset(0, .1), curve: Curves.easeOut),
    );
  }
}

class _MenuTextBtn extends StatelessWidget {
  const _MenuTextBtn({
    required this.label,
    required this.onTap,
  });
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: kWhite,
              fontVariations: fontWeightW500,
            ),
          ),
        ),
      ),
    );
  }
}
