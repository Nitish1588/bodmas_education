import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart';
import '../model/cutoff_model.dart';

class CutoffService {

  Future<List<CutoffModel>> getCutoffs({
    int page = 1,
    int? stateId,
    int? courseId,
  }) async {
    try {
      String url = "${Env.baseUrl}/paid-cutoffs?page=$page";

      if (stateId != null) {
        url += "&state_id=$stateId";
      }

      if (courseId != null) {
        url += "&course_id=$courseId";
      }

      final uri = Uri.parse(url);

      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 15));

      // 1. Status code check
      if (response.statusCode != 200) {
        throw Exception(
          "Failed to load cutoffs. Status Code: ${response.statusCode}",
        );
      }

      // 2. Decode safely
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['data'] == null || data['data']['data'] == null) {
        return [];
      }

      final List list = data['data']['data'];

      return list
          .map((e) => CutoffModel.fromJson(e))
          .toList();

    } on http.ClientException catch (e) {
      throw Exception("Network error: ${e.message}");
    } on FormatException {
      throw Exception("Invalid response format from server");
    } on Exception catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }
}