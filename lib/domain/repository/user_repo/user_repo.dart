import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class UserRepo {
  static Future<List<UserModel>> fetchUserDetails() async {
    Dio dio = Dio();
    String token = await UserToken.getToken();
    String userId = await CurrentUserId.getUserId();
    String userListUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.allUsers}";
    List<UserModel> users = [];
    try {
      var response = await dio.get(
        userListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Fetch User Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        List userList = responseData['user'];
        for (int i = 0; i < userList.length; i++) {
          UserModel user = UserModel.fromJson(userList[i]);
          if (user.id != userId) {
            users.add(user);
          }
        }
        return users;
      }
      return [];
    } catch (e) {
      debugPrint('Fetch User Error: ${e.toString()}');
      return [];
    }
  }

  static Future<UserDetailsModel?> fetchUserDetailsById(String userId) async {
    Dio dio = Dio();
    String token = await UserToken.getToken();
    String userDetailUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.user}$userId";
    List<PostModel> posts = [];
    try {
      var response = await dio.get(
        userDetailUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Fetch User By Id Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        UserModel user = UserModel.fromJson(responseData['user']);
        final List postsList = responseData['posts'];
        for (int i = 0; i < postsList.length; i++) {
          PostModel post = PostModel.fromJson(postsList[i]);
          if (!post.isBlocked) {
            posts.add(post);
          }
        }
        return UserDetailsModel(user: user, posts: posts);
      }
      return null;
    } catch (e) {
      debugPrint('Fetch User By Id Error: $e');
      return null;
    }
  }

  static Future<FollowUnfollowModel> followUser(String userId) async {
    Dio dio = Dio();
    String token = await UserToken.getToken();
    String followUserUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.followUser}$userId";
    try {
      var response = await dio.patch(
        followUserUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Follow User Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        List followersIdList = jsonResponse['newUser']['followers'];
        List followingIdList = jsonResponse['newUser']['following'];
        return FollowUnfollowModel(
          message: 'success',
          followers: [...followersIdList],
          following: [...followingIdList],
        );
      }
      return FollowUnfollowModel(
          message: 'failure', followers: [], following: []);
    } catch (e) {
      debugPrint('Follow User Error: $e');
      return FollowUnfollowModel(
          message: 'failure', followers: [], following: []);
    }
  }

  static Future<FollowUnfollowModel> unfollowUser(String userId) async {
    Dio dio = Dio();
    String token = await UserToken.getToken();
    String followUserUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.unfollowUser}$userId";
    try {
      var response = await dio.patch(
        followUserUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Unfollow User Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        var jsonResponse = response.data;
        List followersIdList = jsonResponse['newUser']['followers'];
        List followingIdList = jsonResponse['newUser']['following'];
        return FollowUnfollowModel(
          message: 'success',
          followers: [...followersIdList],
          following: [...followingIdList],
        );
      }
      return FollowUnfollowModel(
          message: 'failure', followers: [], following: []);
    } catch (e) {
      debugPrint('Unfollow User Status: $e');
      return FollowUnfollowModel(
          message: 'failure', followers: [], following: []);
    }
  }

  static Future<List<UserModel>> searchUsers(String value) async {
    Dio dio = Dio();
    String token = await UserToken.getToken();
    String searchUserUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.userSearch}?query=$value";
    List<UserModel> users = [];
    try {
      var response = await dio.get(
        searchUserUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Search Users Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        List userList = responseData['users'];
        for (int i = 0; i < userList.length; i++) {
          UserModel user = UserModel.fromJson(userList[i]);
          users.add(user);
        }
        return users;
      }
      return [];
    } catch (e) {
      debugPrint('Search Users Error: $e');
      return [];
    }
  }

  static Future<String> reportUser(String userId, String description) async {
    final client = http.Client();
    String token = await UserToken.getToken();
    String reportUserUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.reportUser}";
    try {
      var data = {
        "description": description,
        'reportUserId': userId,
      };
      var response = await client.post(
        Uri.parse(reportUserUrl),
        body: data,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Report User Status: ${response.statusCode}');

      if (response.statusCode == 201) {
        return 'success';
      }
      if (response.statusCode == 400) {
        debugPrint('Report Post Body: ${response.body.toString()}');
        return 'already-reported';
      }
      return '';
    } catch (e) {
      debugPrint('Report User Error: $e');
      return '';
    }
  }
}

class UserDetailsModel {
  final UserModel user;
  final List<PostModel> posts;

  UserDetailsModel({
    required this.user,
    required this.posts,
  });
}

class FollowUnfollowModel {
  final String message;
  final List<String> followers;
  final List<String> following;

  FollowUnfollowModel({
    required this.message,
    required this.followers,
    required this.following,
  });
}
