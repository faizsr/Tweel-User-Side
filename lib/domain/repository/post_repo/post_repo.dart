import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';
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
      debugPrint('Fetch Post Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final List postsList = response.data;
        for (int i = 0; i < postsList.length; i++) {
          PostModel post = PostModel.fromJson(postsList[i]);
          if (!post.isBlocked) {
            posts.add(post);
          }
        }
        return posts;
      }
      return [];
    } catch (e) {
      debugPrint('Fetch Post Error: ${e.toString()}');
      return [];
    }
  }

  static Future<PostModel?> fetchPostsById(String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String getPostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.getPostById}$postId";
    try {
      var response = await dio.get(
        getPostUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Fetch Post Status: ${response.statusCode}');
      if (response.statusCode == 201) {
        final jsonResponse = response.data;
        print(jsonResponse['data']);
        PostModel post = PostModel.fromJson(jsonResponse['data']);
        return post;
      }
      return null;
    } catch (e) {
      debugPrint('Fetch Post Error: ${e.toString()}');
      return null;
    }
  }

  static Future<String> createPost(
      String location, String description, List<String> imageUrlList) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String createPostUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.createPost}";
    try {
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
      debugPrint('Create Post Status: ${response.statusCode}');

      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Create Post Error: $e');
      return '';
    }
  }

  static Future<String> editPost(PostModel post) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String editPostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.editPost}${post.id}";
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
      debugPrint('Edit Post Status: ${response.statusCode}');

      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Edit Post Error: $e');
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
      debugPrint('Remove Post Status: ${response.statusCode}');
      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Remove Post Error: $e');
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
      debugPrint('Add Comment Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Add Comment Error: $e');
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
      debugPrint('Delete Comment Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Delete Comment Status: $e');
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
      debugPrint('Like Post Status: ${response.statusCode}');
      if (response.statusCode == 201) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Like Post Error: $e');
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
      debugPrint('Unlike Post Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Unlike Post Error: $e');
      return '';
    }
  }

  static Future<String> savePost(String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String savePostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.savePost}$postId";
    try {
      var response = await dio.post(
        savePostUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      debugPrint('Save Post Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Save Post Error: $e');
      return '';
    }
  }

  static Future<String> unsavePost(String postId) async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String unsavePostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.unsavePost}$postId";
    try {
      var response = await dio.patch(
        unsavePostUrl,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }),
      );
      debugPrint('Unsave Post Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        return 'success';
      }
      return '';
    } catch (e) {
      debugPrint('Unsave Post Error: $e');
      return '';
    }
  }

  static Future<List<PostModel>> fetchAllSavedPost() async {
    final dio = Dio();
    String token = await UserToken.getToken();
    String fetchAllSavedPostUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.allSavedPosts}";
    List<PostModel> savedPosts = [];
    try {
      var response = await dio.get(
        fetchAllSavedPostUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      debugPrint('Fetch Saved Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        var responseData = response.data['saved-posts']['posts'];
        List savedPostsList = responseData;
        for (int i = 0; i < savedPostsList.length; i++) {
          PostModel savedPost = PostModel.fromJson(savedPostsList[i]);
          savedPosts.add(savedPost);
        }
        return savedPosts;
      }
      return [];
    } catch (e) {
      debugPrint('Fetch Saved Error: $e');
      return [];
    }
  }

  static Future<String> reportPost(String postId, String description) async {
    final client = http.Client();
    String token = await UserToken.getToken();
    String reportPostUrl = "${ApiEndPoints.baseUrl}${ApiEndPoints.reportPost}";
    try {
      var data = {
        'postId': postId,
        'description': description,
      };
      var response = await client.post(
        Uri.parse(reportPostUrl),
        body: data,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      debugPrint('Report Post Status: ${response.statusCode}');
      debugPrint('Report Post Body: ${response.body.toString()}');

      if (response.statusCode == 201) {
        return 'success';
      }
      if (response.statusCode == 400) {
        return 'already-reported';
      }
      return '';
    } catch (e) {
      debugPrint('Report Post Error: $e');
      return '';
    }
  }
}
