import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart';

class BlogService {

  static Future<Map<String, dynamic>> fetchBlogs(int page) async {

    final response = await http.get(
      Uri.parse("${Env.baseUrlApi}/blog-all-posts?page=$page"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load blogs");
    }
  }

}