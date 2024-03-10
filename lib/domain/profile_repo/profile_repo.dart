import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/core/utils/shared_preference.dart';
import 'package:tweel_social_media/data/models/post_model/user_post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class ProfileRepo {
  static Future<ProfileDetailsModel?> fetchUserDetails() async {
    var client = http.Client();
    String token = await UserToken.getToken();
    String userDetailUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.userProfile}";
    List<UserPostModel> posts = [];
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
          UserPostModel post = UserPostModel.fromJson(postsList[i]);
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
}

class ProfileDetailsModel {
  final UserModel user;
  final List<UserPostModel> posts;

  ProfileDetailsModel({
    required this.user,
    required this.posts,
  });
}
