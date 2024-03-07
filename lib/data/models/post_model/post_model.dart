import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class PostModel {
  final String id;
  final String description;
  final String location;
  final List mediaURL;
  final List likes;
  final List comments;
  final String createdDate;
  final String updatedDate;
  final UserModel user;
  bool isBlocked;

  PostModel({
    required this.id,
    required this.description,
    required this.location,
    required this.mediaURL,
    required this.likes,
    required this.comments,
    required this.createdDate,
    required this.updatedDate,
    required this.user,
    this.isBlocked = false,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['_id'],
        description: json['description'],
        location: json['location'],
        mediaURL: json['mediaURL'],
        likes: json['likes'],
        comments: json['comments'],
        createdDate: json['createdAt'],
        updatedDate: json['updatedAt'],
        isBlocked: json['isBlocked'],
        user: UserModel.fromJson(json['userId']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'description': description,
        'location': location,
        'mediaURL': mediaURL,
        'likes':likes,
        'comments':comments,
        'createdAt': createdDate,
        'updatedAt':updatedDate,
        'isBlocked': isBlocked,
        'userId': user.toJson(),
      };
}
