import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

class CreateLoadingSnackbar {
  static showSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        backgroundColor: kBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        behavior: SnackBarBehavior.floating,
        content: const Row(
          children: [
            Text('Uploading...'),
            Spacer(),
            SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
