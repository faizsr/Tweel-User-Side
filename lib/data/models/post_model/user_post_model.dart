import 'package:tweel_social_media/data/models/post_model/post_model.dart';

class UserPostModel {
  final String id;
  final String description;
  final String location;
  final List mediaURL;
  final List likes;
  final List<CommentModel> comments;
  final String createdDate;
  final String updatedDate;
  final String userId;
  bool isBlocked;

  UserPostModel({
    required this.id,
    required this.description,
    required this.location,
    required this.mediaURL,
    required this.likes,
    required this.comments,
    required this.createdDate,
    required this.updatedDate,
    required this.userId,
    this.isBlocked = false,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) {
    return UserPostModel(
      id: json['_id'],
      description: json['description'],
      location: json['location'],
      mediaURL: json['mediaURL'],
      likes: json['likes'],
      comments: json['comments'] == null
          ? []
          : List<CommentModel>.from(json['comments']!
              .map((comment) => CommentModel.fromJson(comment))),
      createdDate: json['createdAt'],
      updatedDate: json['updatedAt'],
      userId: json['userId'],
      isBlocked: json['isBlocked'],
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'description': description,
        'location': location,
        'mediaURL': mediaURL,
        'likes': likes,
        'comments': comments.map((comment) => comment.toJson()).toList(),
        'createdAt': createdDate,
        'updatedAt': updatedDate,
        'userId': userId,
        'isBlocked': isBlocked,
      };
}
