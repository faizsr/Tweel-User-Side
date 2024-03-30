part of 'profile_logics_bloc.dart';

@immutable
sealed class ProfileLogicsState {}

final class ProfileLogicsInitial extends ProfileLogicsState {}

class EditUserDetailsLoadingState extends ProfileLogicsState {}

class EditUserDetailsSuccessState extends ProfileLogicsState {}

class EditUsernameAlreadyExistsState extends ProfileLogicsState {}

class EditUserDetailsErrorState extends ProfileLogicsState {}
