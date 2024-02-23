import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tweel_social_media/core/utils/api_endpoints.dart';

class ForgetRepo {
  static Future<String> forgetSendOtp({required String email}) async {
    debugPrint(email);
    var client = http.Client();
    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.forgetSendOtp}";
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
        return 'user-not-found';
      }
      return 'error';
    } catch (e) {
      debugPrint(e.toString());
      return 'error';
    }
  }

  static Future<String> resetPassword(
      {required String email,
      required String otp,
      required String password}) async {
    debugPrint(email);
    var client = http.Client();
    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.resetPassword}";
    try {
      var body = {
        "email": email,
        "otp": otp,
        "password": password,
      };
      var response = await client.post(
        Uri.parse(signUpUrl),
        body: body,
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
      debugPrint(e.toString());
      return 'error';
    }
  }
}
