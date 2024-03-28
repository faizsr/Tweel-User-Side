import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
import 'package:tweel_social_media/data/models/story_model/story_model.dart';

class StoryRepo {
  static Future<List<StoryModel>> getAllStories() async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String storyListUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.allStories}";
    List<StoryModel> posts = [];
    try {
      var response = await dio.get(
        storyListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Fetch Stories Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List storyList = response.data;
        for (int i = 0; i < storyList.length; i++) {
          StoryModel post = StoryModel.fromJson(storyList[i]);
          posts.add(post);
        }
        return posts;
      }
      return [];
    } catch (e) {
      debugPrint('Fetch Stories Error: ${e.toString()}');
      return [];
    }
  }

  static Future<String> addStory(String userId, String imageUrl) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String addPostUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.addStory}";
    try {
      var data = {
        "userId": userId,
        "image": imageUrl,
      };
      var response = await dio.post(
        addPostUrl,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Add Story Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Add Story Error: $e');
      return '';
    }
  }
}
