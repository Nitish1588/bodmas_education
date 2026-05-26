import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart';
import '../model/course_model.dart';
import '../model/state_model.dart';

class FilterService {
  /// =========================
  /// COURSES
  /// =========================
  Future<List<CourseModel>> getCourses() async {
    try {
      List<CourseModel> allCourses = [];
      int page = 1;
      bool hasNextPage = true;

      while (hasNextPage) {
        final uri = Uri.parse("${Env.baseUrlApi}/courses?page=$page");

        final response = await http
            .get(uri)
            .timeout(const Duration(seconds: 15));

        /// STATUS CHECK
        if (response.statusCode != 200) {
          throw Exception(
            "Failed to load courses. "
            "Status code: ${response.statusCode}",
          );
        }

        /// DECODE
        final Map<String, dynamic> data = jsonDecode(response.body);

        /// SAFE LIST EXTRACTION
        final List coursesData = data['data'] ?? [];

        /// MAP DATA
        allCourses.addAll(
          coursesData.map((e) => CourseModel.fromJson(e)).toList(),
        );

        /// NEXT PAGE CHECK
        if (data['links'] != null && data['links']['next'] != null) {
          page++;
        } else {
          hasNextPage = false;
        }
      }
      return allCourses;
    } on http.ClientException catch (e) {
      throw Exception("Network error: ${e.message}");
    } on FormatException {
      throw Exception("Invalid courses response format");
    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  /// =========================
  /// STATES
  /// =========================
  Future<List<StateModel>> getStates() async {
    try {
      final uri = Uri.parse("${Env.baseUrlApi}/states");

      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      /// STATUS CHECK
      if (response.statusCode != 200) {
        throw Exception(
          "Failed to load states. "
          "Status code: ${response.statusCode}",
        );
      }

      /// DECODE
      final dynamic data = jsonDecode(response.body);

      /// SAFETY CHECK
      if (data is! List) {
        throw Exception("Invalid states response format");
      }

      return data.map<StateModel>((e) => StateModel.fromJson(e)).toList();
    } on http.ClientException catch (e) {
      throw Exception("Network error: ${e.message}");
    } on FormatException {
      throw Exception("Invalid JSON format");
    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }
}
