import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart';

class EventService {
  static String url = "${Env.baseUrlApi}/events";
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