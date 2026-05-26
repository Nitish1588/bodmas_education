class PurchaseModel {

  final bool status;

  final String type;

  final int purchaseId;

  final String razorpayOrderId;

  final int amount;

  PurchaseModel({
    required this.status,
    required this.type,
    required this.purchaseId,
    required this.razorpayOrderId,
    required this.amount,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) {

    final data = json['data'];

    return PurchaseModel(
      status: json['status'] ?? false,
      type: data['type'] ?? '',
      purchaseId: data['purchase_id'] ?? 0,
      razorpayOrderId: data['razorpay_order_id'] ?? '',
      amount: data['amount'] ?? 0,
    );
  }
}