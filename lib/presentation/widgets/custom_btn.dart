import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/forget_password/forget_password_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/report/report_bloc.dart';
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
    var theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        color: theme.colorScheme.primary,
        onPressed: onPressed,
        child: MultiBlocBuilder(
          blocs: [
            context.watch<SignInBloc>(),
            context.watch<SignUpBloc>(),
            context.watch<ForgetPasswordBloc>(),
            context.watch<ReportBloc>(),
          ],
          builder: (context, states) {
            var state1 = states[0];
            var state2 = states[1];
            var state3 = states[2];
            var state4 = states[3];
            return state1 is UserSignInLoadingState ||
                    state2 is UserOtpLoadingState ||
                    state2 is UserSignUpLoadingState ||
                    state3 is ForgetSentOtpLoadingState ||
                    state3 is ForgetResetPasswordLoadingState ||
                    state4 is ReportUserLoadingState ||
                    state4 is ReportPostLoadingState
                ? SizedBox(
                    height: 22,
                    width: 22,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  )
                : FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    duration: const Duration(milliseconds: 1000),
                    child: Text(
                      buttonText,
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
