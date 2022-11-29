import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService   {
  final String auth_token = "auth_token";

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(auth_token);
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(auth_token, token);
  }

}