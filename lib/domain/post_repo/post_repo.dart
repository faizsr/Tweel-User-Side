import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/core/utils/shared_preference.dart';
import 'package:tweel_social_media/data/models/post_model/post_model.dart';

class PostRepo {
  static Future<List<PostModel>> fetchAllPosts() async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String postListUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.allPosts}";
    List<PostModel> posts = [];
    try {
      var response = await dio.get(
        postListUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List postsList = response.data;
        for (int i = 0; i < postsList.length; i++) {
          PostModel post = PostModel.fromJson(postsList[i]);
          posts.add(post);
        }
        return posts;
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
