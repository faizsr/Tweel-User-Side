class StoryModel {
  final String id;
  final Map<String, dynamic> user;
  final String image;
  final String createdDate;

  StoryModel({
    required this.id,
    required this.user,
    required this.image,
    required this.createdDate,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        id: json['_id'],
        user: json['userId'],
        image: json['image'],
        createdDate: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": user,
        "image": image,
        "createdAt": createdDate,
      };
}
