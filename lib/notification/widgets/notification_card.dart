import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
class NotificationCard extends StatelessWidget {
  final Map data;

  const NotificationCard({super.key, required this.data});
  Future<void> downloadAndOpenPDF(String url) async {
    try {
      final dir = await getTemporaryDirectory();
      final filePath = "${dir.path}/${url.split('/').last}";

      await Dio().download(url, filePath);

      await OpenFile.open(filePath);

    } catch (e) {
      //print("Error: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withAlpha(22),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 TOP ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TYPE BADGE
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data['type'] ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),

              // DATE
              Text(
                data['created_at'].toString().substring(0, 10),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),

              GestureDetector(
                onTap: () {
                  final pdfUrl =
                      "https://bodmaseducation.com/notice/${data['file']}";
                  downloadAndOpenPDF(pdfUrl);


                },
                child: const Icon(Icons.picture_as_pdf, color: Colors.green),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 🔹 TITLE
          Text(
            data['title'] ?? "",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 6),

          // 🔹 DESCRIPTION
          Text(
            data['description'] ?? "",
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}