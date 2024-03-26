class SavedPostModel {
  String? sId;
  String? userId;
  String? description;
  List<String>? mediaURL;
  List<String>? likes;
  List<String>? comments;
  String? location;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SavedPostModel(
      {this.sId,
      this.userId,
      this.description,
      this.mediaURL,
      this.likes,
      this.comments,
      this.location,
      this.isBlocked,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SavedPostModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    description = json['description'];
    mediaURL = json['mediaURL'].cast<String>();
    likes = json['likes'].cast<String>();
    comments = json['comments'].cast<String>();
    location = json['location'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() => {
        '_id': sId,
        'userId': userId,
        'description': description,
        'mediaURL': mediaURL,
        'likes': likes,
        'comments': comments,
        'location': location,
        'isBlocked': isBlocked,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}
