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
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0.5),
            borderRadius: BorderRadius.circular(3),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.all(0)
        ),
        onPressed: onPressed,
        child: Text(
          btnText,
          style: const TextStyle(
            fontVariations: fontWeightW900,
            color: kBlack,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
