part of 'user_by_id_bloc.dart';

@immutable
sealed class UserByIdEvent {}

class FetchUserByIdEvent extends UserByIdEvent {
  final String userId;

  FetchUserByIdEvent({
    required this.userId,
  });
}
