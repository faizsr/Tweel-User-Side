import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/theme/color_theme.dart';
import 'package:tweel_social_media/core/utils/constants.dart';

Future<dynamic> nextScreen(context, page) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

Future<dynamic> nextScreenReplacement(context, page) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

Future<dynamic> nextScreenRemoveUntil(context, page) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
    (route) => false,
  );
}

customSnackbar(BuildContext context, String message,
    {IconData? leading, String? trailing}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      backgroundColor: dLightBlueGrey2,
      dismissDirection: DismissDirection.up,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          if (leading != null)
            Icon(
              leading,
              color: lWhite,
            ),
          kWidth(10),
          Text(
            message,
            style: const TextStyle(color: lWhite),
          ),
          const Spacer(),
          if (trailing != null)
            Text(
              trailing,
              style: const TextStyle(
                fontVariations: fontWeightW700,
                fontSize: 12,
                color: lWhite,
              ),
            )
        ],
      ),
    ),
  );
}

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final bool disableTitle;
  final String? description;
  final double? descriptionTxtSize;
  final bool? disableActionBtn;
  final String? popBtnText;
  final Function()? onTap;
  final String? actionBtnTxt;
  const CustomAlertDialog({
    super.key,
    this.title,
    this.disableTitle = true,
    this.description,
    this.descriptionTxtSize,
    this.onTap,
    this.disableActionBtn = false,
    this.popBtnText,
    this.actionBtnTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(height: disableTitle ? 15 : 0),
        disableTitle
            ? Text(
                title ?? '',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox(),
        kHeight(12),
        Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Text(
            description ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: descriptionTxtSize ?? 13,
                color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        kHeight(10),
        Divider(
          height: 1,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        disableActionBtn == false
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: InkWell(
                  onTap: onTap,
                  child: Center(
                    child: Text(
                      actionBtnTxt ?? 'Delete',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        Divider(
          height: disableActionBtn == false ? 1.2 : 0,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 45,
          child: InkWell(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15),
            ),
            highlightColor: Colors.grey[200],
            onTap: () {
              Navigator.of(context).pop('refresh');
            },
            child: Center(
              child: Text(
                popBtnText != null ? popBtnText ?? '' : 'Cancel',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
