import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart';
import '../model/purchased_cutoff_model.dart';

class PurchasedCutoffService {
  /// GET PURCHASED CUTOFFS
  Future<List<PurchasedCutoffModel>> getPurchasedCutoffs({
    required String token,
  }) async {
    final response = await http.get(
      Uri.parse("${Env.baseUrl}/paid-cutoffs/my-packages"),

      headers: {'Authorization': 'Bearer $token'},
    );

    final data = jsonDecode(response.body);
    return (data['data'] as List)
        .map((e) => PurchasedCutoffModel.fromJson(e))
        .toList();
  }

  /// DOWNLOAD PDF
  String downloadUrl(int packageId) {
    return "${Env.baseUrl}/paid-cutoffs/download";
  }
}
