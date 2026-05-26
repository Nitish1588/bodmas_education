class PurchasedCutoffModel {
  final int id;
  final int packageId;
  final String amount;
  final String status;
  final String createdAt;
  final String productName;
  final String image;

  PurchasedCutoffModel({
    required this.id,
    required this.packageId,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.productName,
    required this.image,
  });

  factory PurchasedCutoffModel.fromJson(Map<String, dynamic> json) {
    final package = json['package'];

    return PurchasedCutoffModel(
      id: json['id'],
      packageId: json['package_id'],
      amount: json['amount'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      productName: package['product_name'] ?? '',
      image: package['images'] ?? '',
    );
  }
}
