import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/core/utils/shared_preference.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class UserRepo {
  static Future<List<UserModel>> fetchUserDetails() async {
    Dio dio = Dio();
    String token = await UserToken.getToken();
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
      // debugPrint("json response ::::: ${response.data}");
      debugPrint('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        List userList = responseData['user'];
        for (int i = 0; i < userList.length; i++) {
          // debugPrint(':::::: ${userList[0]}');
          UserModel post = UserModel.fromJson(userList[i]);
          users.add(post);
        }
        return users;
      }
      return [];
    } catch (e) {
      debugPrint('message2: ${e.toString()}');
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
      // debugPrint("json response ::::: ${response.statusCode}");
      debugPrint('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        UserModel user = UserModel.fromJson(responseData['user']);
        final List postsList = responseData['posts'];
        for (int i = 0; i < postsList.length; i++) {
          // debugPrint(':::::: ${postsList[0]}');
          PostModel post = PostModel.fromJson(postsList[i]);
          posts.add(post);
        }
        return UserDetailsModel(user: user, posts: posts);
      }
      return null;
    } catch (e) {
      debugPrint('message: ${e.toString()}');
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
      return FollowUnfollowModel(
          message: 'failure', followers: [], following: []);
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
