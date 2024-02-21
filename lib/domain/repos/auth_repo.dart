import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tweel_social_media/core/api_endpoints.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class AuthRepo {
  static Future<bool> userSignUp({required UserModel user}) async {
    var client = http.Client();
    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userSignUp}";
    try {
      var response =
          await client.post(Uri.parse(signUpUrl), body: jsonEncode(user));
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> userVerifyOtp({required String email}) async {
    var client = http.Client();
    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userVerifyOtp}";
    try {
      var response = await client.post(Uri.parse(signUpUrl),
          body: jsonEncode({"email": email}));
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
