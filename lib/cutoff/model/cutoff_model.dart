class CutoffModel {
  final int id;
  final String productName;
  final String image;
  final String salePrice;
  final String regularPrice;
  final String description;
  final String createdAt;

  CutoffModel({
    required this.id,
    required this.productName,
    required this.image,
    required this.salePrice,
    required this.regularPrice,
    required this.description,
    required this.createdAt,
  });

  factory CutoffModel.fromJson(Map<String, dynamic> json) {
    return CutoffModel(
      id: json['id'],
      productName: json['product_name'] ?? '',
      image: json['images'] ?? '',
      salePrice: json['sale_price'] ?? '',
      regularPrice: json['ragular_price'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
