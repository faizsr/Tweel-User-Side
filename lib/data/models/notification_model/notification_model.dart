import 'package:tweel_social_media/data/models/post_model/post_model.dart';
import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class NotificationModel {
  final String notifyId;
  final String userId;
  final String type;
  final PostModel? post;
  final UserModel user;
  final String createdAt;
  final String updatedAt;

  NotificationModel({
    required this.notifyId,
    required this.userId,
    required this.type,
    this.post,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notifyId: json['_id'],
      userId: json['userId'],
      type: json['type'],
      post: json['postId'] != null ? PostModel.fromJson(json['postId']) : null,
      user: UserModel.fromJson(json['by']),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': notifyId,
        'userId': userId,
        'type': type,
        'postId': post!.toJson(),
        'by': user,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
