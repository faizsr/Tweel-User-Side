import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tweel_social_media/core/utils/api_endpoints.dart';
import 'package:tweel_social_media/data/models/chat_model/chat_model.dart';
import 'package:tweel_social_media/data/services/shared_preference/shared_preference.dart';

class ChatRepo {
  static Future<List<ChatModel>> fetchUserChats() async {
    Dio dio = Dio();
    String token = await UserToken.getToken();
    // String userId = await CurrentUserId.getUserId();
    String currentUserChatsUrl =
        "${ApiEndPoints.baseUrl}${ApiEndPoints.currentUserChats}";
    List<ChatModel> chats = [];
    try {
      var response = await dio.get(
        currentUserChatsUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      debugPrint('Fetch User Chats Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        List userList = responseData['data'];
        for (int i = 0; i < userList.length; i++) {
          ChatModel chat = ChatModel.fromJson(userList[i]);
          chats.add(chat);
        }
        return chats;
      }
      return [];
    } catch (e) {
      debugPrint('Fetch User Chats Error: ${e.toString()}');
      return [];
    }
  }
}
