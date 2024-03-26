part of 'saved_posts_bloc.dart';

@immutable
sealed class SavedPostsEvent {}

class FetchAllSavedPostEvent extends SavedPostsEvent {}