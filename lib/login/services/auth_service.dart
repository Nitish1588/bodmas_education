import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart';

class AuthService {

  static final baseUrl = "${Env.baseUrl}/auth";

  // SEND OTP
  static Future<bool> sendOtp(String phone) async {

    try {

      final res = await http.post(
        Uri.parse("$baseUrl/send-otp"),
        headers: {"Accept": "application/json"},
        body: {"phone": phone},
      );

      print("STATUS CODE: ${res.statusCode}");
      print("BODY: ${res.body}");

      final data = jsonDecode(res.body);

      return data["status"] == true;

    } catch (e) {

      print("SEND OTP ERROR: $e");

      return false;
    }
  }


  static Future<Map<String, dynamic>?> verifyOtp(String phone, String otp) async {
    try {

      final res = await http.post(
        Uri.parse("$baseUrl/verify-otp"),
        headers: {"Accept": "application/json"},
        body: {"phone": phone, "otp": otp},
      );

      print("STATUS CODE: ${res.statusCode}");
      print("BODY: ${res.body}");

      return jsonDecode(res.body);

    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }

  // REGISTER
  static Future<Map<String, dynamic>?> register(
      String phone,
      String name,
      String email,
      ) async {

    try {

      final res = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {"Accept": "application/json"},
        body: {
          "phone": phone,
          "name": name,
          "email": email,
        },
      );

      return jsonDecode(res.body);

    } catch (e) {

      print("REGISTER ERROR: $e");

      return null;
    }
  }


  // GET USER (ME API)
  static Future<Map<String, dynamic>?> getMe(String token) async {

    print("SENDING TOKEN: $token");

    final res = await http.get(
      Uri.parse("$baseUrl/me"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("STATUS: ${res.statusCode}");
    print("BODY: ${res.body}");

    return jsonDecode(res.body);
  }
  static Future<Map<String, dynamic>?> getUser(String token) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUrl/me"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      print("ME STATUS: ${res.statusCode}");
      print("ME BODY: ${res.body}");

      return jsonDecode(res.body);

    } catch (e) {
      print("GET USER ERROR: $e");
      return null;
    }
  }

  // LOGOUT
  static Future<bool> logout(String token) async {
    final res = await http.post(
      Uri.parse("$baseUrl/logout"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    final data = jsonDecode(res.body);
    return data["status"] == true;
  }


}

