class CourseModel {
  final int id;
  final int type;
  final String name;
  final String price;
  final String description;

  CourseModel({
    required this.id,
    required this.type,
    required this.name,
    required this.price,
    required this.description,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
    );
  }
}

class TimeSlotModel {
  final int id;
  final String startTime;
  final String endTime;
  final String status;

  TimeSlotModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
      id: json['id'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      status: json['status'],
    );
  }
}


