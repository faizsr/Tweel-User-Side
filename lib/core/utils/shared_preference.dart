import 'package:shared_preferences/shared_preferences.dart';

class UserToken {
  static Future<String> getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? bearer = preferences.getString('TOKEN');
    return bearer!;
  }

  static saveToken(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('TOKEN', token);
  }
}

// Shared preference for managing Sign in and Sign up
class UserAuthStatus {
  static Future<bool> getUserStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool? status = preferences.getBool('SIGNIN');
    return status ?? false;
  }

  static Future<bool> isUserOnInitial() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final bool? status = preferences.getBool('ON_INITIAL');
    return status ?? false;
  }

  static saveUserinitialStatus(bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('ON_INITIAL', status);
  }

  static saveUserStatus(bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('SIGNIN', status);
  }
}
