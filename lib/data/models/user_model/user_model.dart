import 'package:tweel_social_media/data/models/post_model/post_model.dart';

class UserModel {
  final String? id;
  final String? username;
  final String? password;
  final String? email;
  final int? phoneNumber;
  final String? accountType;
  final String? profilePicture;
  final String? bio;
  final String? fullName;
  final List<PostModel>? posts;
  final List? followers;
  final List? following;
  final bool? isBlocked;
  final String? createdAt;
  final String? updatedAt;
  final String? otp;

  UserModel({
    this.id,
    this.username,
    this.password,
    this.email,
    this.phoneNumber,
    this.accountType,
    this.profilePicture,
    this.bio,
    this.fullName,
    this.posts,
    this.followers,
    this.following,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.otp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        phoneNumber: json['phonenumber'],
        accountType: json['account_type'],
        profilePicture: json['profile_picture'],
        bio: json['bio'],
        fullName: json['fullname'],
        posts: json['posts'],
        followers: json['followers'],
        following: json['following'],
        isBlocked: json['isBlocked'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        otp: json['otp'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "password": password,
        "email": email,
        "phonenumber": phoneNumber,
        "account_type": accountType,
        "profile_picture": profilePicture,
        "bio": bio,
        "fullname": fullName,
        "posts": posts,
        "followers": followers,
        "following": following,
        "isBlocked": isBlocked,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "otp": otp,
      };
}
