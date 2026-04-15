import 'dart:convert';
import 'package:http/http.dart' as http;

class EventService {
  static const String url = "https://bodmaseducation.com/api/events";
  static const String imageBase = "https://bodmaseducation.com/images/events/";

  static Future<List<dynamic>> fetchEvents() async {
    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      throw Exception("Failed to load events");
    }
  }
}