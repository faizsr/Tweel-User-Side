import 'package:flutter_bloc/flutter_bloc.dart';

class PostImageIndexCubit extends Cubit<int> {
  PostImageIndexCubit() : super(0);

  void onPageChange(int value) {
    emit(value);
  }
}
