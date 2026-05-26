import 'dart:convert';
import 'package:bodmas_education/profile/profile_screen.dart';
import 'package:bodmas_education/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import '../cutoff/service/payment_service.dart';
import '../env.dart';
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

    Future.delayed(const Duration(milliseconds: 100), openPayment);
  }

  // 🔥 OPEN PAYMENT
  Future<void> openPayment() async {
    String? key = await PaymentService.getRazorpayKey();
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
    debugPrint("razorpayKey** => $key");
    var options = {
      "key": key,
      "amount": widget.amount,
      "order_id": widget.orderId,
      "currency": "INR",
      "prefill": {
        "contact": widget.phone,
        "email": widget.email,
      }
    };

    debugPrint("ORDER ID (AAA): ${widget.orderId}");
    debugPrint("amount (AAA): ${widget.amount}");
    try {
      _razorpay.open(options);
      debugPrint("ORDER ID (BACKEND): ${widget.orderId}");
      debugPrint("amount (BACKEND): ${widget.amount}");
      debugPrint("RAZORPAY OPEN : ");
    } catch (e) {
      debugPrint("❌ RAZORPAY OPEN ERROR: $e");
    }
  }

  // ✅ PAYMENT SUCCESS
  Future<void> _onSuccess(PaymentSuccessResponse response) async {
    final paymentId = response.paymentId;
    final orderId = response.orderId; // 👈 IMPORTANT (backend wala use karo)
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

      "razorpay_order_id": orderId,
      "razorpay_payment_id": paymentId,
      "razorpay_signature": signature,

      "amount": widget.amount,
      "name": widget.name,
      "email": widget.email,
      "phone": widget.phone,
    };

    debugPrint("📤 VERIFY BODY:");
    debugPrint(jsonEncode(body));

    try {
      final res = await http.post(
        Uri.parse("${Env.baseUrl}/payment/verify"),
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

        AppSnackBar.show(context, message: "Payment Successful",type: SnackBarType.success);

        Navigator.push(context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        ),
    );
        Navigator.popUntil(context, (route) => route.isFirst);

      } else {

        debugPrint("❌ VERIFY FAILED: ${data['message']}");

        AppSnackBar.show(context, message: data['message'] ?? "Verify failed",type: SnackBarType.error);

        //ScaffoldMessenger.of(context).showSnackBar(
       //   SnackBar(content: Text(data['message'] ?? "Verify failed")),
       // );

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
            "${Env.baseUrl}/payment/failure"),
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

    AppSnackBar.show(context, message: "Payment Failed",type: SnackBarType.error);


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