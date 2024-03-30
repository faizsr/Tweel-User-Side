part of 'profile_logics_bloc.dart';

@immutable
sealed class ProfileLogicsEvent {}

class EditUserDetailEvent extends ProfileLogicsEvent {
  final UserModel updatedUser;
  final UserModel intialUser;
  final List<AssetEntity> profilePicture;

  EditUserDetailEvent({
    required this.updatedUser,
    required this.intialUser,
    required this.profilePicture,
  });
}