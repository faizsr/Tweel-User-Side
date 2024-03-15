part of 'set_profile_image_cubit.dart';

@immutable
sealed class SetProfileImageState {}

final class SetProfileImageInitial extends SetProfileImageState {}

class SetProfileImageSuccessState extends SetProfileImageState {
  final List<AssetEntity> selectedImage;

  SetProfileImageSuccessState({
    required this.selectedImage,
  });
}
