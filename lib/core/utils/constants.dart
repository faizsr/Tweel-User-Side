
import 'package:flutter/material.dart';

const kWhite = Colors.white;
const kLightWhite = Color(0xFFF5F6FA);
const kLightGrey = Color(0xFFF4F4F4);
const kGray = Color(0xFF8F8F8F);
const kDarkGrey = Color(0xFF4B4B4B);
const kBlack = Colors.black;
const kDarkBlue = Color(0xFF3E23A9);

const profileOne = 'assets/images/profile1.jpg';
const profileTwo = 'assets/images/profile2.jpg';
const profileThree = 'assets/images/profile3.jpg';
const profileFour = 'assets/images/profile4.jpg';
const profileFive = 'assets/images/profile5.jpg';

const fontWeightW300 = <FontVariation>[FontVariation('wght', 300.0)];
const fontWeightRegular = <FontVariation>[FontVariation('wght', 400.0)];
const fontWeightW500 = <FontVariation>[FontVariation('wght', 500.0)];
const fontWeightW600 = <FontVariation>[FontVariation('wght', 600.0)];
const fontWeightW700 = <FontVariation>[FontVariation('wght', 700.0)];
const fontWeightW800 = <FontVariation>[FontVariation('wght', 800.0)];
const fontWeightW900 = <FontVariation>[FontVariation('wght', 900.0)];

SizedBox kHeight(double? height) => SizedBox(height: height);
SizedBox kWidth(double? width) => SizedBox(width: width);

nextScreen(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

nextScreenReplacement(context, page) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

nextScreenRemoveUntil(context, page) {
  Navigator.pushAndRemoveUntil(
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
      backgroundColor: kBlack,
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

var kBoxShadow = [
  BoxShadow(
    blurRadius: 40,
    color: Colors.black.withOpacity(0.05),
  ),
];
