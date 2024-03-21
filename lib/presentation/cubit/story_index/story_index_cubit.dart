import 'package:flutter_bloc/flutter_bloc.dart';

class StoryIndexCubit extends Cubit<int> {
  int index = 0;
  StoryIndexCubit() : super(0);

  void currentIndex(int current) {
    index = current;
    emit(index);
  }
}
