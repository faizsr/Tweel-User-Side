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
          // debugPrint('From message ::: ${postsList[0]}');
          PostModel post = PostModel.fromJson(postsList[i]);
          posts.add(post);
        }
        return posts;
      }
      return [];
    } catch (e) {
      debugPrint('messsaage: ${e.toString()}');
      return [];
    }
  }

  static Future<String> createPost(
      String location, String description, List<String> imageUrlList) async {
    debugPrint('image url lenght: ${imageUrlList.length}');
    debugPrint('image 1: ${imageUrlList[0]}');
    final dio = Dio();
    String token = await UserToken.getToken();
    String createPostUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.createPost}";
    try {
      print(imageUrlList.isEmpty);
      print(description);
      print(location);
      var data = {
        "postData": {
          "description": description,
          'image': imageUrlList,
          "location": location,
        }
      };
      var response = await dio.post(createPostUrl,
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  static Future<String> editPost(PostModel post) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String editPostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.editPost}${post.id}";
    print('on repo');
    print(post.id);
    print(post.description);
    print(post.location);
    print(post.mediaURL!.length);
    try {
      var data = {
        "description": post.description,
        'image': post.mediaURL,
        "location": post.location,
      };
      var response = await dio.patch(editPostUrl,
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      print(response.statusCode);
      print(response.data);

      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  static Future<String> removePost(String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String removePostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.removePost}$postId";
    try {
      var response = await dio.delete(removePostUrl,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ));
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  static Future<String> addComment(String comment, String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String addCommentUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.addComment}";
    var data = {
      "postId": postId,
      "comment": comment,
    };
    try {
      var response = await dio.post(
        addCommentUrl,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  static Future<String> deleteComment(String commentId, String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String deleteCommentUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.deleteComment}";
    var data = {
      "postId": postId,
      "commentId": commentId,
    };
    try {
      var response = await dio.post(
        deleteCommentUrl,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Error: $e');
      return '';
    }
  }

  static Future<String> likePost(String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String likePostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.likePost}$postId";
    try {
      var response = await dio.patch(
        likePostUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      debugPrint('${response.statusCode}');
      debugPrint(response.data.toString());
      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }

  static Future<String> unlikePost(String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String likePostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.unlikePost}$postId";
    try {
      var response = await dio.patch(
        likePostUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      debugPrint('${response.statusCode}');
      debugPrint(response.data.toString());
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
  }
}
