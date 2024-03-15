part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class UserDetailInitialFetchEvent extends ProfileEvent {}

class EditUserDetailEvent extends ProfileEvent {
  final UserModel updatedUser;
  final UserModel intialUser;
  final List<AssetEntity> profilePicture;

  EditUserDetailEvent({
    required this.updatedUser,
    required this.intialUser,
    required this.profilePicture,
  });
}
