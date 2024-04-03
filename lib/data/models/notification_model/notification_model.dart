import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class NotificationModel {
  final String notifyId;
  final String userId;
  final String type;
  final UserModel user;
  final String createdAt;
  final String updatedAt;

  NotificationModel({
    required this.notifyId,
    required this.userId,
    required this.type,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notifyId: json['_id'],
      userId: json['userId'],
      type: json['type'],
      user: UserModel.fromJson(json['by']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': notifyId,
        'userId': userId,
        'type': type,
        'by': user,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

