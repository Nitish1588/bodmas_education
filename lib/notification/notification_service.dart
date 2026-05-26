import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart';

class NotificationService {
  static final String url =
      "${Env.baseUrlApi}/notifications";

  static Future<List<dynamic>> fetchNotifications() async {
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to load notifications");
    }
  }
}