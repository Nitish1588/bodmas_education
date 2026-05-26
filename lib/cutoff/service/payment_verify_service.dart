import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../env.dart';

class PaymentVerifyService {
  Future<bool> verifyPayment({

    required int purchaseId,
    required String razorpayOrderId,
    required String razorpayPaymentId,
    required String razorpaySignature,
    required String token,

  }) async {

    final response = await http.post(
      Uri.parse(
        "${Env.baseUrl}/paid-cutoffs/verify-payment",
      ),

      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },

      body: jsonEncode({
        "purchase_id": purchaseId,
        "razorpay_order_id": razorpayOrderId,
        "razorpay_payment_id": razorpayPaymentId,
        "razorpay_signature": razorpaySignature,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 &&
        data['status'] == true) {

      return true;

    } else {
      throw Exception(
        data['message'] ??
            'Payment verification failed',
      );
    }
  }
}