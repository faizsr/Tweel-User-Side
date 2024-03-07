import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/core/utils/shared_preference.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class ProfileRepo {
  static Future<UserModel?> fetchUserDetails() async {
    var client = http.Client();
    String token = await UserToken.getToken();
    String userDetailUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userProfile}";
    try {
      var response = await client.get(
        Uri.parse(userDetailUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> usersList = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(usersList);
        return user;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
