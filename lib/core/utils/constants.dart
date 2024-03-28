// <<<<<<< HEAD

// =======
// >>>>>>> 3dc048ca250c0fed2f942660e1d93d69a36a53b2
import 'package:flutter/material.dart';

const kLightGrey = Color(0xFFF4F4F4);
const kLightGrey2 = Color(0xFFCCCCCC);

const profileOne = 'assets/images/profile1.jpg';
const profileTwo = 'assets/images/profile2.jpg';
const profileThree = 'assets/images/profile3.jpg';
const profileFour = 'assets/images/profile4.jpg';
const profileFive = 'assets/images/profile5.jpg';
const profilePlaceholder = 'assets/images/profile_placeholder.jpg';

const fontWeightW300 = <FontVariation>[FontVariation('wght', 300.0)];
const fontWeightRegular = <FontVariation>[FontVariation('wght', 400.0)];
const fontWeightW500 = <FontVariation>[FontVariation('wght', 500.0)];
const fontWeightW600 = <FontVariation>[FontVariation('wght', 600.0)];
const fontWeightW700 = <FontVariation>[FontVariation('wght', 700.0)];
const fontWeightW800 = <FontVariation>[FontVariation('wght', 800.0)];
const fontWeightW900 = <FontVariation>[FontVariation('wght', 900.0)];

SizedBox kHeight(double? height) => SizedBox(height: height);
SizedBox kWidth(double? width) => SizedBox(width: width);

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

customSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      behavior: SnackBarBehavior.floating,
      content: Text(message),
    ),
  );
}

formattedTime({required int timeInSecond}) {
  int sec = timeInSecond % 60;
  int min = (timeInSecond / 60).floor();
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "$minute:$second";
}

String timeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year' : 'years'} ago';
  } else if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  } else if (difference.inDays >= 7) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
  } else if (difference.inDays > 0) {
    return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'min' : 'min'} ago';
  } else {
    return 'Just now';
  }
}

String filterPostTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays > 365) {
    final years = (difference.inDays / 365).floor();
    return '$years${years == 1 ? 'y' : 'y'}';
  } else if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return '$months${months == 1 ? 'm' : 'm'}';
  } else if (difference.inDays >= 7) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks${weeks == 1 ? 'w' : 'w'}';
  } else if (difference.inDays > 0) {
    return '${difference.inDays}${difference.inDays == 1 ? 'd' : 'd'}';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}${difference.inHours == 1 ? 'h' : 'h'}';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}${difference.inMinutes == 1 ? 'min' : 'min'}';
  } else {
    return 'Just now';
  }
}

var kBoxShadow = [
  BoxShadow(
    blurRadius: 40,
    color: Colors.black.withOpacity(0.05),
  ),
];

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
      backgroundColor: const Color(0xFFFFFFFF),
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
            style: TextStyle(fontSize: descriptionTxtSize ?? 13),
          ),
        ),
        kHeight(10),
        Divider(
          height: 1,
          color: Colors.grey.shade200,
        ),
        disableActionBtn == false
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: onTap,
                  child: Center(
                    child: Text(
                      actionBtnTxt ?? 'Delete',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF1285b9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        Divider(
          height: disableActionBtn == false ? 1.2 : 0,
          color: Colors.grey.shade200,
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
