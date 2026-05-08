import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

import '../login/services/session.dart';

class PaymentScreen extends StatefulWidget {
  final int bookingId;
  final String orderId;
  final int amount;
  final String name;
  final String email;
  final String phone;

  const PaymentScreen({
    super.key,
    required this.bookingId,
    required this.orderId,
    required this.amount,
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    debugPrint("🚀 INIT PAYMENT SCREEN");

    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onWallet);

    Future.delayed(const Duration(milliseconds: 500), openPayment);
  }

  // 🔥 OPEN PAYMENT
  void openPayment() {
    debugPrint("========== OPEN PAYMENT ==========");
    print(Session.user);
    print(Session.user?["id"]);
    print(Session.user?["name"]);
    debugPrint("ORDER ID: ${widget.orderId}");
    debugPrint("AMOUNT (paise): ${widget.amount}");
    debugPrint("NAME: ${widget.name}");
    debugPrint("EMAIL: ${widget.email}");
    debugPrint("PHONE: ${widget.phone}");

    if (widget.orderId.isEmpty) {
      debugPrint("❌ ERROR: Order ID EMPTY");
      return;
    }

    if (widget.amount <= 0) {
      debugPrint("❌ ERROR: Amount INVALID");
      return;
    }

    var options = {
      // "key": "rzp_test_sjrrHSYgdgmQOv",
      // "amount": 10000,
      // "name": "Test",

      "key": "rzp_test_sjrrHSYgdgmQOv",
      "amount": widget.amount,
      "order_id": widget.orderId,
      "currency": "INR",
      "name": "Bodmas Education",
      "description": "Consultation Booking",
      "prefill": {
        "contact": widget.phone,
        "email": widget.email,
      }
    };

    try {
      _razorpay.open(options);
      debugPrint("RAZORPAY OPEN : ");
    } catch (e) {
      debugPrint("❌ RAZORPAY OPEN ERROR: $e");
    }
  }

  // ✅ PAYMENT SUCCESS
  Future<void> _onSuccess(PaymentSuccessResponse response) async {
    final paymentId = response.paymentId;
    final orderId = widget.orderId; // 👈 IMPORTANT (backend wala use karo)
    final signature = response.signature;

// DEBUG
    debugPrint("PAYMENT ID: $paymentId");
    debugPrint("ORDER ID (BACKEND): $orderId");
    debugPrint("SIGNATURE: $signature");
    debugPrint(response.toString());

// ❌ agar signature null hai to stop
    if (signature == null) {
      debugPrint("❌ ERROR: Signature null → payment invalid");
      return;
    }
    debugPrint("========== PAYMENT SUCCESS ==========");
    debugPrint("paymentId: ${response.paymentId}");
    debugPrint("orderId: ${response.orderId}");
    debugPrint("signature: ${response.signature}");
    debugPrint(response.toString());

    // ❌ CRITICAL CHECK
    if (response.signature == null || response.paymentId == null) {
      debugPrint("❌ INVALID PAYMENT RESPONSE (signature/paymentId null)");
      return;
    }

    final body = {
      "booking_id": widget.bookingId,
      "module": "booking",
      "module_id": widget.bookingId.toString(),

      "razorpay_order_id": orderId,        // 👈 FIXED
      "razorpay_payment_id": paymentId,    // 👈 FIXED
      "razorpay_signature": signature,     /// for temporary bases was "test_signature"

      "amount": widget.amount,
      "name": widget.name,
      "email": widget.email,
      "phone": widget.phone,
    };

    debugPrint("📤 VERIFY BODY:");
    debugPrint(jsonEncode(body));

    try {
      final res = await http.post(
        Uri.parse("https://bodmaseducation.com/api/v1/payment/verify"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      debugPrint("📥 STATUS CODE: ${res.statusCode}");
      debugPrint("📥 RAW RESPONSE:");
      debugPrint(res.body);

      if (res.statusCode != 200) {
        debugPrint("❌ SERVER ERROR (NOT 200)");
        return;
      }

      final data = json.decode(res.body);

      debugPrint("📥 PARSED RESPONSE:");
      debugPrint(data.toString());

      if (data['status'] == true) {
        debugPrint("✅ PAYMENT VERIFIED SUCCESS");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment Successful")),
        );

        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        debugPrint("❌ VERIFY FAILED: ${data['message']}");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? "Verify failed")),
        );
      }
    } catch (e) {
      debugPrint("❌ VERIFY EXCEPTION: $e");
    }
  }

  // ❌ PAYMENT FAILED
  Future<void> _onError(PaymentFailureResponse response) async {
    debugPrint("========== PAYMENT FAILED ==========");
    debugPrint("Code: ${response.code}");
    debugPrint("Message: ${response.message}");

    try {
      final res = await http.post(
        Uri.parse(
            "https://bodmaseducation.com/api/v1/payment/failure"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "booking_id": widget.bookingId,
        }),
      );

      debugPrint("Failure API Status: ${res.statusCode}");
      debugPrint("Failure API Response: ${res.body}");
    } catch (e) {
      debugPrint("❌ FAILURE API ERROR: $e");
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Failed")),
    );

    Navigator.pop(context);
  }

  void _onWallet(ExternalWalletResponse response) {
    debugPrint("Wallet: ${response.walletName}");
  }

  @override
  void dispose() {
    debugPrint("🧹 DISPOSE PAYMENT SCREEN");
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}