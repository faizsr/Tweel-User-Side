part of 'like_unlike_post_bloc.dart';

@immutable
sealed class LikeUnlikePostState {}

final class LikeUnlikePostInitial extends LikeUnlikePostState {}

class LikedPostState extends LikeUnlikePostState {}

class UnlikedPostState extends LikeUnlikePostState {}