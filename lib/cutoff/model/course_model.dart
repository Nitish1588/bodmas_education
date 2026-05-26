class CourseModel {

  final int id;
  final String title;

  CourseModel({
    required this.id,
    required this.title,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {

    return CourseModel(
      id: json['id'],
      title: json['title'],
    );
  }
}