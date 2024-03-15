import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

part 'set_profile_image_state.dart';

class SetProfileImageCubit extends Cubit<SetProfileImageState> {
  SetProfileImageCubit() : super(SetProfileImageInitial());

  void setProfileImage(List<AssetEntity> selectedImage) {
    emit(SetProfileImageSuccessState(selectedImage: selectedImage));
  }

  void resetState() {
    emit(SetProfileImageInitial());
  }
}
