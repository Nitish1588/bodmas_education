import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart';
import '../model/purchase_model.dart';

class PurchaseService {
  Future<PurchaseModel> purchaseCutoff({
    required int packageId,
    required String token,
  }) async {
    final response = await http.post(
      Uri.parse("${Env.baseUrl}/paid-cutoffs/purchase"),

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },

      body: jsonEncode({"package_id": packageId.toString()}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == true) {
      return PurchaseModel.fromJson(data);
    } else {
      throw Exception(data['message'] ?? 'Payment initialization failed');
    }
  }
}
