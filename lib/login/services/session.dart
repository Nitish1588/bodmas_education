import 'package:shared_preferences/shared_preferences.dart';

class Session {

  static Future<void> saveToken(String token) async {
    try {
      final pref = await SharedPreferences.getInstance();
      await pref.setString("token", token);
      print("TOKEN SAVED");
    } catch (e) {
      print("SAVE TOKEN ERROR: $e");
    }
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString("token");
  }

  static Future<void> clear() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}