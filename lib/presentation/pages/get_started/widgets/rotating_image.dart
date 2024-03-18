import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class LoginAssets extends StatefulWidget {
  const LoginAssets({super.key});

  @override
  State<LoginAssets> createState() => _LoginAssetsState();
}

class _LoginAssetsState extends State<LoginAssets>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );

    _animation = Tween<double>(begin: 0.2, end: 0).animate(_controller);

    _controller.addListener(() {
      if (mounted && context.mounted) {
        setState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            bottom: 0,
            left: 20,
            right: 20,
            child: Padding(
              padding: EdgeInsets.all(60.0),
              child: CircleAvatar(
                backgroundColor: kLightWhite,
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(profileOne),
                  ),
                ),
              ),
            ),
          ),
          AnimatedRotation(
            turns: 1 - _animation.value,
            duration: const Duration(seconds: 10),
            child: DottedBorder(
              borderType: BorderType.Circle,
              radius: const Radius.circular(30),
              color: kGray,
              strokeWidth: 1,
              dashPattern: const [10, 10],
              child: Container(
                height: 400,
                width: 400,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Stack(
                  children: [
                    Positioned(
                      top: 70,
                      left: 20,
                      child: RotationTransition(
                        turns: _animation,
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(profileTwo),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60,
                      right: 20,
                      child: RotationTransition(
                        turns: _animation,
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(profileThree),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      right: 210,
                      child: RotationTransition(
                        turns: _animation,
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(profileFour),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 60,
                      left: 220,
                      child: RotationTransition(
                        turns: _animation,
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(profileFive),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
