import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/core/utils/shared_preference.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class ProfileRepo {
  static Future<ProfileDetailsModel?> fetchUserDetails() async {
    var client = http.Client();
    String token = await UserToken.getToken();
    String userDetailUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userProfile}";
    List<PostModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse(userDetailUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // debugPrint("json response ::::: ${response.statusCode}");
      debugPrint('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(responseData['user']);
        final List postsList = responseData['posts'];
        for (int i = 0; i < postsList.length; i++) {
          // debugPrint(':::::: ${postsList[0]}');
          PostModel post = PostModel.fromJson(postsList[i]);
          posts.add(post);
        }
        return ProfileDetailsModel(user: user, posts: posts);
      }
      return null;
    } catch (e) {
      debugPrint('message: ${e.toString()}');
      return null;
    }
  }

  static Future<String> updateUserDetails(UserModel user) async {
    var client = http.Client();
    String token = await UserToken.getToken();
    String updateDetailUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.editUserProfile}";
    try {
      var response = await client.patch(
        Uri.parse(updateDetailUrl),
        body: jsonEncode(user),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Status code: ${response.statusCode}');
      debugPrint('Response: ${response.body}');
      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('message: ${e.toString()}');
      return '';
    }
  }
}

class ProfileDetailsModel {
  final UserModel user;
  final List<PostModel> posts;

  ProfileDetailsModel({
    required this.user,
    required this.posts,
  });
}
