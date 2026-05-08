import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Session {

  static String? token;
  static Map<String, dynamic>? user;

  /// =========================
  /// SAVE TOKEN
  /// =========================
  static Future<void> saveToken(String t) async {
    final pref = await SharedPreferences.getInstance();

    await pref.setString("token", t);

    token = t;
  }

  /// =========================
  /// GET TOKEN
  /// =========================
  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();

    token = pref.getString("token");

    return token;
  }

  /// =========================
  /// SAVE USER
  /// =========================
  static Future<void> saveUser(Map<String, dynamic>? u) async {

    if (u == null) return;

    final pref = await SharedPreferences.getInstance();

    await pref.setString("user", jsonEncode(u));

    user = u;

    print("USER SAVED");
    print(user);
  }

  /// =========================
  /// GET USER
  /// =========================
  static Future<Map<String, dynamic>?> getUser() async {

    final pref = await SharedPreferences.getInstance();

    String? userData = pref.getString("user");

    if (userData != null) {

      /// STRING -> MAP
      user = jsonDecode(userData);

      return user;
    }

    return null;
  }

  /// =========================
  /// CHECK LOGIN
  /// =========================
  static Future<bool> isLogin() async {

    String? t = await getToken();

    return t != null;
  }

  /// =========================
  /// CLEAR SESSION
  /// =========================
  static Future<void> clear() async {

    final pref = await SharedPreferences.getInstance();

    await pref.remove("token");
    await pref.remove("user");

    token = null;
    user = null;
  }
}