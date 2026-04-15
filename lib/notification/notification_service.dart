import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  static const String url =
      "https://bodmaseducation.com/api/notifications";

  static Future<List<dynamic>> fetchNotifications() async {
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to load notifications");
    }
  }
}