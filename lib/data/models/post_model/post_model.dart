import 'package:tweel_social_media/data/models/user_model/user_model.dart';

class PostModel {
  final String? id;
  final String description;
  final String location;
  final List? mediaURL;
  final List? likes;
  final List<CommentModel>? comments;
  final String? createdDate;
  final String? updatedDate;
  final UserModel? user;
  final String? userId;
  bool isBlocked;

  PostModel({
    this.id,
    required this.description,
    required this.location,
    this.mediaURL,
    this.likes,
    this.comments,
    this.createdDate,
    this.updatedDate,
    this.user,
    this.userId,
    this.isBlocked = false,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
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
      isBlocked: json['isBlocked'],
      user: json['userId'] is Map<String, dynamic>
          ? UserModel.fromJson(json['userId'])
          : UserModel(),
      userId: json['userId'] is String ? json['userId'] : '',
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'description': description,
        'location': location,
        'mediaURL': mediaURL,
        'likes': likes,
        'comments': comments is Map<String, dynamic>
            ? comments!.map((comment) => comment.toJson()).toList()
            : [],
        'createdAt': createdDate,
        'updatedAt': updatedDate,
        'isBlocked': isBlocked,
        'userId': user is Map<String, dynamic> ? user?.toJson() : userId,
      };
}

class CommentModel {
  final String id;
  final UserModel user;
  final String comment;
  final String createdDate;

  CommentModel({
    this.id = '',
    required this.user,
    required this.comment,
    required this.createdDate,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['_id'],
        user: UserModel.fromJson(json['userId']),
        comment: json['comment'],
        createdDate: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': user.toJson(),
        'comment': comment,
        'createdAt': createdDate,
      };
}
