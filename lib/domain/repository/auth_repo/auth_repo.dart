import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class AuthRepo {
  static Future<SignUpResult> userSignUp({required UserModel user}) async {
    var client = http.Client();
    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userSignUp}";
    try {
      var response = await client.post(
        Uri.parse(signUpUrl),
        body: jsonEncode(user),
        headers: {'Content-Type': 'application/json'},
      );

      var jsonResponse = jsonDecode(response.body);
      debugPrint('User Sign Up Status: ${response.statusCode}');
      debugPrint('User Sign Up Body: ${response.body}');

      if (response.statusCode == 201) {
        await UserAuthStatus.saveUserStatus(true);
        await UserToken.saveToken(jsonResponse['token']);
        await CurrentUserId.saveUserId(jsonResponse['userId']);
        return SignUpResult(status: 'success', responseBody: response.body);
      }
      if (response.statusCode == 400) {
        return SignUpResult(status: 'invalid-otp', responseBody: null);
      }

      if (response.statusCode == 409) {
        if (jsonResponse['error'] ==
            "Username Already Taken. Please Choose different one or login instead") {
          return SignUpResult(status: 'username-exists', responseBody: null);
        } else if (jsonResponse['error'] ==
            "A user with this email address already exist. Please login instead") {
          return SignUpResult(status: 'email-exists', responseBody: null);
        } else if (jsonResponse['error'] ==
            "A user with this Phone Number already exist. Please login instead") {
          return SignUpResult(status: 'phoneno-exists', responseBody: null);
        }
      }
      return SignUpResult(status: 'error', responseBody: null);
    } catch (e) {
      debugPrint('User Sign Up Error: $e');
      return SignUpResult(status: 'error', responseBody: null);
    }
  }

  static Future<SignInResult> userSignIn(
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
      debugPrint('User Sign In Status: ${response.statusCode}');
      if (response.statusCode == 201) {
        await UserAuthStatus.saveUserStatus(true);
        await UserToken.saveToken(jsonResponse['token']);
        await CurrentUserId.saveUserId(jsonResponse['userId']);
        return SignInResult(status: 'success', responseBody: jsonResponse);
      }
      if (response.statusCode == 400) {
        return SignInResult(status: 'invalid-username', responseBody: null);
      }
      if (response.statusCode == 401) {
        if (jsonResponse['error'] == "User Has Been Blocked by Admin") {
          return SignInResult(status: 'blocked-by-admin', responseBody: null);
        }
        if (jsonResponse['error'] == "Invalid Password") {
          return SignInResult(status: 'invalid-password', responseBody: null);
        }
      }
      return SignInResult(status: 'error', responseBody: null);
    } catch (e) {
      debugPrint('User Sign in Status: $e');
      return SignInResult(status: 'error', responseBody: null);
    }
  }

  static Future<String> userVerifyOtp({required String email}) async {
    var client = http.Client();
    String signUpUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userVerifyOtp}";
    try {
      var body = {"email": email};
      var response = await client.post(
        Uri.parse(signUpUrl),
        body: body,
      );
      debugPrint('User Verify Otp Status: ${response.statusCode}');
      debugPrint('User Verify Otp Body: ${response.body}');

      if (response.statusCode == 200) {
        return 'success';
      }
      if (response.statusCode == 401) {
        return 'already-exists';
      }
      return 'error';
    } catch (e) {
      debugPrint('User Verify Otp Error: $e');
      return 'error';
    }
  }
}

class SignInResult {
  final String? status;
  final dynamic responseBody;

  SignInResult({this.status, this.responseBody});
}

class SignUpResult {
  final String? status;
  final dynamic responseBody;

  SignUpResult({this.status, this.responseBody});
}
