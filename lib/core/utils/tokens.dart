import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final String? bearer = preferences.getString('TOKEN');
  return bearer!;
}

saveToken(String token) async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('TOKEN', token);
}
