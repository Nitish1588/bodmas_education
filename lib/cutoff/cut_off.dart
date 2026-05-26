import 'package:bodmas_education/cutoff/service/cutoff_service.dart';
import 'package:bodmas_education/cutoff/service/filter_service.dart';
import 'package:bodmas_education/cutoff/service/payment_verify_service.dart';
import 'package:bodmas_education/cutoff/service/purchase_service.dart';
import 'package:bodmas_education/cutoff/service/razorpay_service.dart';
import 'package:bodmas_education/cutoff/widgets/cutoff_card.dart';
import 'package:bodmas_education/cutoff/widgets/cutoff_header.dart';
import 'package:bodmas_education/cutoff/widgets/filter_section.dart';
import 'package:bodmas_education/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../login/services/session.dart';
import 'model/course_model.dart';
import 'model/cutoff_model.dart';
import 'model/purchase_model.dart';
import 'model/state_model.dart';

class CutOffScreen extends StatefulWidget {
  const CutOffScreen({super.key});

  @override
  State<CutOffScreen> createState() => _CutOffScreenState();
}

class _CutOffScreenState extends State<CutOffScreen> {
  RazorpayService? razorpayService;

  /// API DATA
  List<CutoffModel> cutoffs = [];

  /// EXPANDED CARD INDEX
  int? expandedIndex;

  List<CourseModel> courses = [];
  List<StateModel> states = [];
  int? selectedCourseId;
  int? selectedStateId;
  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    loadFilters();
    loadCutoffs();
  }

  Future<void> loadFilters() async {
    final courseData = await FilterService().getCourses();
    final stateData = await FilterService().getStates();
    setState(() {
      courses = courseData;
      states = stateData;
    });
  }

  Future<void> loadCutoffs({bool isNewSearch = false}) async {
    if (isLoadingMore) return;
    setState(() {
      isLoadingMore = true;
    });

    if (isNewSearch) {
      currentPage = 1;
      cutoffs.clear();
      hasMoreData = true;
    }

    final data = await CutoffService().getCutoffs(
      page: currentPage,
      stateId: selectedStateId,
      courseId: selectedCourseId,
    );

    setState(() {
      if (data.isEmpty) {
        hasMoreData = false;
      } else {
        cutoffs.addAll(data);
        currentPage++;
      }
      isLoadingMore = false;
    });
  }

  Future<void> handlePayment(CutoffModel cutoff) async {
    debugPrint("========== HANDLE PAYMENT START ==========");
    try {
      debugPrint("Showing loading dialog...");

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Please wait...",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

      /// TOKEN
      debugPrint("Fetching token...");

      final token = await Session.getToken();

      debugPrint("TOKEN => $token");

      if (token == null || token.isEmpty) {
        debugPrint("Token missing or empty");

        if (mounted && Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        if (!mounted) return;
        AppSnackBar.show(
          context,
          message: 'Please login first',
          type: SnackBarType.warning,
        );

        return;
      }

      /// PURCHASE API
      debugPrint("Calling purchaseCutoff API...");

      final PurchaseModel purchase = await PurchaseService().purchaseCutoff(
        packageId: cutoff.id,
        token: token,
      );

      debugPrint("PURCHASE SUCCESS");
      debugPrint("purchaseId => ${purchase.purchaseId}");
      debugPrint("razorpayOrderId => ${purchase.razorpayOrderId}");
      debugPrint("amount => ${purchase.amount}");

      if (mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }

      /// RAZORPAY
      debugPrint("Initializing RazorpayService...");
      if (!mounted) return;
      razorpayService = RazorpayService(
        context: context,

        onSuccess: (PaymentSuccessResponse response) async {
          debugPrint("========== PAYMENT SUCCESS CALLBACK ==========");
          debugPrint("orderId => ${response.orderId}");
          debugPrint("paymentId => ${response.paymentId}");
          debugPrint("signature => ${response.signature}");

          try {
            debugPrint("Showing verification loader...");

            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) {
                return const Center(child: CircularProgressIndicator());
              },
            );

            debugPrint("Calling verifyPayment API...");

            final verified = await PaymentVerifyService().verifyPayment(
              purchaseId: purchase.purchaseId,
              razorpayOrderId: response.orderId ?? '',

              /// response.orderId
              razorpayPaymentId: response.paymentId ?? '',
              razorpaySignature: response.signature ?? '',
              token: token,
            );

            debugPrint("VERIFY RESULT => $verified");
            if (!mounted) return;
            Navigator.pop(context);

            if (verified) {
              debugPrint("Payment verified successfully");

              AppSnackBar.show(
                context,
                message: 'Payment Verified Successfully',
                type: SnackBarType.success,
              );
            } else {
              debugPrint("Payment verification failed");

              AppSnackBar.show(
                context,
                message: 'Payment Verification Failed',
                type: SnackBarType.error,
              );
            }
          } catch (e, stackTrace) {
            debugPrint("VERIFY PAYMENT ERROR => $e");
            debugPrint("STACKTRACE => $stackTrace");

            Navigator.pop(context);

            AppSnackBar.show(
              context,
              message: e.toString(),
              type: SnackBarType.info,
            );
          }
        },
      );

      debugPrint("Opening Razorpay Checkout...");

      razorpayService?.openCheckout(
        orderId: purchase.razorpayOrderId,
        amount: purchase.amount,
        name: cutoff.productName,
        contact: '',
        email: '',
      );

      debugPrint("========== CHECKOUT OPENED ==========");
    } catch (e, stackTrace) {
      debugPrint("HANDLE PAYMENT ERROR => $e");
      debugPrint("STACKTRACE => $stackTrace");

      Navigator.pop(context);

      AppSnackBar.show(
        context,
        message: e.toString().replaceFirst("Exception: ", ""),
        type: SnackBarType.info,
      );
    }
  }

  @override
  void dispose() {
    razorpayService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),

      appBar: AppBar(title: const Text("Cut-Off")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CutoffHeader(),
            const SizedBox(height: 20),

            FilterSection(
              courses: courses,
              states: states,
              selectedCourse: selectedCourseId,
              selectedState: selectedStateId,
              onCourseChanged: (value) {
                setState(() {
                  selectedCourseId = value;
                });
              },

              onStateChanged: (value) {
                setState(() {
                  selectedStateId = value;
                });
              },

              onSearch: () {
                loadCutoffs(isNewSearch: true);
              },
            ),
            const SizedBox(height: 20),

            ListView.builder(
              itemCount: cutoffs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = cutoffs[index];

                return CutoffCard(
                  cutoff: item,
                  expanded: expandedIndex == index,

                  onToggle: () {
                    setState(() {
                      if (expandedIndex == index) {
                        expandedIndex = null;
                      } else {
                        expandedIndex = index;
                      }
                    });
                  },

                  onPay: () {
                    handlePayment(item);
                  },
                );
              },
            ),

            /// LOAD MORE BUTTON
            LoadMoreWidget(
              hasMoreData: hasMoreData,
              isLoadingMore: isLoadingMore,
              loadMore: loadCutoffs,
            ),
          ],
        ),
      ),
    );
  }
}
