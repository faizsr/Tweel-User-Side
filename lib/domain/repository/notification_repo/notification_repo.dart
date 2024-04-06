import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/data/models/notification_model/notification_model.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';

class NotificationRepo {
  static Future<List<NotificationModel>> getAllNotification() async {
    final dio = Dio();
    String getAllNotifyUrl =
        '${ApiEndPoints.baseUrl}${ApiEndPoints.allNotification}';
    String token = await UserToken.getToken();
    List<NotificationModel> notifications = [];
    try {
      final response = await dio.get(getAllNotifyUrl,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseData = response.data;
        final List activities = responseData['activity'];
        for (int i = 0; i < activities.length; i++) {
          NotificationModel activity =
              NotificationModel.fromJson(activities[i]);
          notifications.add(activity);
        }
        return notifications;
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return [];
    }
    return [];
  }

  static Future<bool> clearAllNotification() async {
    final dio = Dio();
    String clearAllNotifyUrl =
        '${ApiEndPoints.baseUrl}${ApiEndPoints.clearNotification}';
    String token = await UserToken.getToken();
    try {
      final response = await dio.delete(
        clearAllNotifyUrl,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
      );
      debugPrint(response.statusCode.toString());
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return false;
    }
    return false;
  }
}
