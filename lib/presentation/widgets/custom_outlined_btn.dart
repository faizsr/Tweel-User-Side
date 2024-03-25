import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CustomOutlinedBtn extends StatelessWidget {
  const CustomOutlinedBtn({
    super.key,
    required this.onPressed,
    required this.btnText,
    this.height = 0,
    this.width = 0,
  });

  final void Function()? onPressed;
  final String btnText;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 0.5, color: theme.textTheme.labelLarge!.color!),
            borderRadius: BorderRadius.circular(3),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.all(0),
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
      ),
    );
  }
}
