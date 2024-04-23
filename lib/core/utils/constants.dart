import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kLightGrey = Color(0xFFF4F4F4);
const kLightGrey2 = Color(0xFFCCCCCC);

const kLightBlueGrey = Color(0xFF373840);

const kTextStyle1 = TextStyle();

const profileOne = 'assets/images/profile1.jpg';
const profileTwo = 'assets/images/profile2.jpg';
const profileThree = 'assets/images/profile3.jpg';
const profileFour = 'assets/images/profile4.jpg';
const profileFive = 'assets/images/profile5.jpg';
const profilePlaceholder = 'assets/images/profile_placeholder.jpg';
const privateIcon = 'assets/images/lock.png';

const fontWeightW300 = <FontVariation>[FontVariation('wght', 300.0)];
const fontWeightRegular = <FontVariation>[FontVariation('wght', 400.0)];
const fontWeightW500 = <FontVariation>[FontVariation('wght', 500.0)];
const fontWeightW600 = <FontVariation>[FontVariation('wght', 600.0)];
const fontWeightW700 = <FontVariation>[FontVariation('wght', 700.0)];
const fontWeightW800 = <FontVariation>[FontVariation('wght', 800.0)];
const fontWeightW900 = <FontVariation>[FontVariation('wght', 900.0)];

SizedBox kHeight(double? height) => SizedBox(height: height);
SizedBox kWidth(double? width) => SizedBox(width: width);

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

bool isToday(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final messageDate = DateTime(date.year, date.month, date.day);
  return today == messageDate;
}

bool isYesterday(DateTime date) {
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final messageDate = DateTime(date.year, date.month, date.day);
  return yesterday == messageDate;
}

String formatTime(DateTime time) {
  return DateFormat('h:mm a').format(time);
}

var kBoxShadow = [
  BoxShadow(
    blurRadius: 40,
    color: Colors.black.withOpacity(0.05),
  ),
];

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
