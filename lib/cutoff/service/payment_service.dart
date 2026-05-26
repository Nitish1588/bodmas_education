import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../env.dart';

class PaymentService {
  static Future<void> fetchAndSaveRazorpayKey() async {
    final response = await http.get(
      Uri.parse('${Env.baseUrl}/payment/payment-config'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['status'] == true) {
        String razorpayKey = data['data']['razorpay_key'];

        // Save locally
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('RAZORPAY_KEY', razorpayKey);
        print("Saved Key: $razorpayKey");
      }
    }
  }

  static Future<String?> getRazorpayKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('RAZORPAY_KEY');
  }
}
