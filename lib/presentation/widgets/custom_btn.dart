import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweel_social_media/presentation/bloc/user_sign_up/sign_up_bloc.dart';

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
        color: Colors.black,
        onPressed: onPressed,
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return state is UserOtpLoadingState
                ? const SizedBox(
                    height: 22,
                    width: 22,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  )
                : Text(
                    buttonText,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  );
          },
        ),
      ),
    );
  }
}
