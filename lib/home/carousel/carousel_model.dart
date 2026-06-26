class CarouselModel {
  final int id;
  final String title;
  final String? buttonUrl;
  final String image;
  final DateTime createdAt;

  CarouselModel({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    this.buttonUrl,
  });

  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      id: json["id"],
      title: json["title"] ?? "",
      buttonUrl: json["button_url"],
      image: "https://bodmaseducation.com/storage/${json["image"]}",
      createdAt: DateTime.parse(json["created_at"]),
    );
  }
}
