import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  static const baseUrl = "https://bodmaseducation.com/api/v1/auth";

  // SEND OTP
  static Future<bool> sendOtp(String phone) async {
    final res = await http.post(
      Uri.parse("$baseUrl/send-otp"),
      headers: {"Accept": "application/json"},
      body: {"phone": phone},
    );

    final data = jsonDecode(res.body);
    return data["status"] == true;
  }

  // VERIFY OTP
  // static Future<Map<String, dynamic>?> verifyOtp(String phone, String otp) async {
  //   final res = await http.post(
  //     Uri.parse("$baseUrl/verify-otp"),
  //     headers: {"Accept": "application/json"},
  //     body: {"phone": phone, "otp": otp},
  //   );
  //
  //   return jsonDecode(res.body);
  // }

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
      String phone, String name, String email) async {

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

