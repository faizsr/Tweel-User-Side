import 'package:flutter_bloc/flutter_bloc.dart';

enum ReportTypeState {
  none,
  hate,
  abuseHarrasment,
  childSafety,
  privacy,
  spam,
  disturbingMedia,
  violent,
  other
}

class ReportRadioCubit extends Cubit<ReportTypeState> {
  ReportRadioCubit() : super(ReportTypeState.none);

  void selectType(ReportTypeState type) {
    emit(type);
  }
}
