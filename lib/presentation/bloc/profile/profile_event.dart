part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class UserDetailInitialFetchEvent extends ProfileEvent {}

class EditUserDetailEvent extends ProfileEvent {
  final UserModel user;

  EditUserDetailEvent({required this.user});
}
