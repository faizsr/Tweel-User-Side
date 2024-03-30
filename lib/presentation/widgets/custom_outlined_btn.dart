import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CustomOutlinedBtn extends StatelessWidget {
  const CustomOutlinedBtn({
    super.key,
    required this.onPressed,
    required this.btnText,
  });

  final void Function()? onPressed;
  final String btnText;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 0.5, color: theme.textTheme.labelLarge!.color!),
          borderRadius: BorderRadius.circular(3),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      onPressed: onPressed,
      child: Text(
        btnText,
        style: TextStyle(
          fontVariations: fontWeightW900,
          color: theme.textTheme.labelLarge!.color,
          fontSize: 10,
        ),
      ),
    );
  }
}
