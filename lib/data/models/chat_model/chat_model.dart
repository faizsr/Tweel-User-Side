import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class ChatModel {
  final String message;
  final UserModel sender;
  final UserModel receiver;
  final DateTime sendAt;

  ChatModel({
    required this.message,
    required this.sender,
    required this.receiver,
    required this.sendAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      message: json['message'],
      sender: UserModel.fromJson(json['sender']),
      receiver: UserModel.fromJson(json['receiver']),
      sendAt: DateTime.parse(json['createdAt']),
    );
  }
}
