import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tweel_social_media/core/api_endpoints.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class AuthRepo {
  static Future<String> userSignUp({required UserModel user}) async {
    var client = http.Client();
    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userSignUp}";
    try {
      var response = await client.post(
        Uri.parse(signUpUrl),
        body: jsonEncode(user),
        headers: {'Content-Type': 'application/json'},
      );
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 201) {
        return 'success';
      }
      if (response.statusCode == 400) {
        return 'invalid-otp';
      }
      return 'error';
    } catch (e) {
      print(e.toString());
      return 'error';
    }
  }

  static Future<String> userVerifyOtp({required String email}) async {
    print(email);
    var client = http.Client();
    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userVerifyOtp}";
    try {
      var body = {"email": email};
      var response = await client.post(
        Uri.parse(signUpUrl),
        body: body,
      );
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return 'success';
      }
      if (response.statusCode == 401) {
        return 'already-exists';
      }
      return 'error';
    } catch (e) {
      print(e.toString());
      return 'error';
    }
  }
}
