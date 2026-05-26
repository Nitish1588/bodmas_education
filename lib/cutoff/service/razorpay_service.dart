import 'package:bodmas_education/cutoff/service/payment_service.dart';
import 'package:bodmas_education/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../env.dart';

class RazorpayService {

  late Razorpay _razorpay;

  final BuildContext context;
  final Future<void> Function(PaymentSuccessResponse)? onSuccess;

  RazorpayService({
    required this.context,
    this.onSuccess,
  }) {

    debugPrint("========== RAZORPAY SERVICE INIT ==========");

    _razorpay = Razorpay();

    debugPrint("Registering Razorpay listeners...");

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess,);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError,);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet,);
  }

  Future<void> openCheckout({
    required String orderId,
    required int amount,
    required String name,
    required String contact,
    required String email,
  }) async {
    String? key = await PaymentService.getRazorpayKey();
    debugPrint("========== OPEN CHECKOUT ==========");
    debugPrint("orderId => $orderId");
    debugPrint("amount => $amount");
    debugPrint("name => $name");
    debugPrint("contact => $contact");
    debugPrint("email => $email");
    debugPrint("razorpayKey => ${Env.razorpayKey}");
    debugPrint("razorpayKey** => $key");



    final options = {
      "key": key,
      'amount': amount,
      'name': name,
      'description': 'Cutoff Purchase',
      'order_id': orderId,
      'prefill': {
        'contact': contact,
        'email': email,
      },
      'theme': {
        'color': '#2663E9',
      },
    };

    debugPrint("RAZORPAY OPTIONS => $options");

    try {

      debugPrint("Opening Razorpay gateway...");
      _razorpay.open(options);
      debugPrint("Razorpay open() called successfully");

    } catch (e, stackTrace) {
      debugPrint("RAZORPAY OPEN ERROR => $e");
      debugPrint("STACKTRACE => $stackTrace");

      AppSnackBar.show(context, message: e.toString(),
      type: SnackBarType.info);

    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response,) async {

    debugPrint("========== PAYMENT SUCCESS ==========");
    debugPrint("paymentId => ${response.paymentId}");
    debugPrint("orderId => ${response.orderId}");
    debugPrint("signature => ${response.signature}");


    AppSnackBar.show(context, message: "Payment Successful",
    type: SnackBarType.success);


    if (onSuccess != null) {
      debugPrint("Calling onSuccess callback...");
      await onSuccess!(response);
      debugPrint("onSuccess callback completed");
    }
  }

  void _handlePaymentError(PaymentFailureResponse response,) {

    debugPrint("========== PAYMENT ERROR ==========");
    debugPrint("code => ${response.code}");
    debugPrint("message => ${response.message}");
    debugPrint("error => ${response.error}");

    AppSnackBar.show(context, message: 'Payment Failed',
    type: SnackBarType.error);    /// message: response.message ?? 'Payment Failed'

  }

  void _handleExternalWallet(ExternalWalletResponse response,) {
    debugPrint("========== EXTERNAL WALLET ==========");
    debugPrint("wallet => ${response.walletName}");

    AppSnackBar.show(context, message: 'External Wallet: ${response.walletName}',
    type: SnackBarType.info);
  }

  void dispose() {
    debugPrint("========== RAZORPAY DISPOSE ==========");
    _razorpay.clear();
  }


}


