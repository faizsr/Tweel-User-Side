import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweel_social_media/core/api_endpoints.dart';
import 'package:tweel_social_media/core/tokens.dart';
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

      var jsonResponse = jsonDecode(response.body);
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 201) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('SIGNIN', true);
        await saveToken(jsonResponse['token']);
        return 'success';
      }
      if (response.statusCode == 400) {
        return 'invalid-otp';
      }
      if (response.statusCode == 409) {
        if (jsonResponse['error'] ==
            "Username Already Taken. Please Choose different one or login instead") {
          return 'username-exists';
        } else if (jsonResponse['error'] ==
            "A user with this email address already exist. Please login instead") {
          return 'email-exists';
        } else if (jsonResponse['error'] ==
            "A user with this Phone Number already exist. Please login instead") {
          return 'phoneno-exists';
        }
      }
      return 'error';
    } catch (e) {
      debugPrint(e.toString());
      return 'error';
    }
  }

  static Future<String> userSignIn(
      {required String username, required String password}) async {
    var client = http.Client();
    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userSignIn}";
    try {
      var user = {
        "username": username,
        "password": password,
      };
      var response = await client.post(
        Uri.parse(signUpUrl),
        body: jsonEncode(user),
        headers: {'Content-Type': 'application/json'},
      );
      var jsonResponse = jsonDecode(response.body);
      debugPrint('Status code: ${response.statusCode}');
      debugPrint(response.body);

      if (response.statusCode == 201) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setBool('SIGNIN', true);
        await saveToken(jsonResponse['token']);
        return 'success';
      }
      if (response.statusCode == 400) {
        return 'invalid-username';
      }
      if (response.statusCode == 401) {
        return 'invalid-password';
      }
      return 'error';
    } catch (e) {
      debugPrint(e.toString());
      return 'error';
    }
  }

  static Future<String> userVerifyOtp({required String email}) async {
    debugPrint(email);
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
      debugPrint(e.toString());
      return 'error';
    }
  }
}
