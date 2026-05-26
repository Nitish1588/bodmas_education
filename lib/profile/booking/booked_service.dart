import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart';

class BookingService {

  static final String url =
      "${Env.baseUrl}/booking/my-bookings";

  static Future<List<dynamic>> fetchBookings(String token) async {

    print("TOKEN: $token");

    final res = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("STATUS CODE: ${res.statusCode}");
    print("BODY: ${res.body}");

    final data = jsonDecode(res.body);

    if (data["status"] == true) {
      return data["data"];
    } else {
      return [];
    }
  }
}