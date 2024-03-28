import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class ProfileRepo {
  static Future<ProfileDetailsModel?> fetchUserDetails() async {
    var client = http.Client();
    String token = await UserToken.getToken();
    String userDetailUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.profile}";
    List<PostModel> posts = [];
    try {
      var response = await client.get(
        Uri.parse(userDetailUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Fetch Users Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        UserModel user = UserModel.fromJson(responseData['user']);
        final List postsList = responseData['posts'];
        for (int i = 0; i < postsList.length; i++) {
          PostModel post = PostModel.fromJson(postsList[i]);
          posts.add(post);
        }
        return ProfileDetailsModel(user: user, posts: posts);
      }
      return null;
    } catch (e) {
      debugPrint('Fetch Users Error: ${e.toString()}');
      return null;
    }
  }

  static Future<String> updateUserDetails(UserModel initialUser,
      UserModel updatedUser, String updateProfilePicture) async {
    var client = http.Client();
    String token = await UserToken.getToken();
    String updateDetailUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.editUserProfile}";
    try {
      Map<String, dynamic> updatedFields = {};
      if (updatedUser.fullName != initialUser.fullName) {
        updatedFields['fullname'] = updatedUser.fullName;
      }
      if (updatedUser.username != initialUser.username) {
        updatedFields['username'] = updatedUser.username;
      }
      if (updatedUser.bio != initialUser.bio) {
        updatedFields['bio'] = updatedUser.bio;
      }
      if (updateProfilePicture != initialUser.profilePicture &&
          updateProfilePicture.isNotEmpty) {
        updatedFields['profile_picture'] = updateProfilePicture;
      }
      var response = await client.patch(
        Uri.parse(updateDetailUrl),
        body: jsonEncode(updatedFields),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Update User Status: ${response.statusCode}');
      if (response.statusCode == 201) {
        return 'success';
      }
      if (response.statusCode == 404) {
        return 'username-exists';
      }
      return '';
    } catch (e) {
      debugPrint('Update User Error: $e');
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
