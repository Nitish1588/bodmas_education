class BookingModel {
  final int id;
  final String course;
  final String date;
  final String time;
  final String type;
  final String status;
  final String price;
  final String location;
  final String createdAt;
  final String? zoomLink;

  BookingModel({
    required this.id,
    required this.course,
    required this.date,
    required this.time,
    required this.type,
    required this.status,
    required this.price,
    required this.location,
    required this.createdAt,
    this.zoomLink,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json["id"],
      course: json["course"] ?? "",
      date: json["date"] ?? "",
      time: json["time"] ?? "",
      type: json["type"] ?? "",
      status: json["status"] ?? "",
      price: json["price"] ?? "",
      location: json["location"] ?? "",
      createdAt: json["created_at"] ?? "",
      zoomLink: json["zoom_link"],
    );
  }
}