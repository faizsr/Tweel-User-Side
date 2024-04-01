import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_in/sign_in_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_up/sign_up_bloc.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    this.onPressed,
  });

  final String buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        color: Theme.of(context).colorScheme.primary,
        onPressed: onPressed,
        child: MultiBlocBuilder(
          blocs: [
            context.watch<SignInBloc>(),
            context.watch<SignUpBloc>(),
            context.watch<ForgetPasswordBloc>(),
          ],
          builder: (context, states) {
            var state1 = states[0];
            var state2 = states[1];
            var state3 = states[2];
            return state1 is UserSignInLoadingState ||
                    state2 is UserOtpLoadingState ||
                    state2 is UserSignUpLoadingState ||
                    state3 is ForgetSentOtpLoadingState ||
                    state3 is ForgetResetPasswordLoadingState
                ? SizedBox(
                    height: 22,
                    width: 22,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  )
                : FadeInUp(
                    delay: const Duration(milliseconds: 700),
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      buttonText,
                      style: const TextStyle(fontSize: 16,color: lWhite),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
