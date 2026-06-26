import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class NotificationCard extends StatelessWidget {
  final Map data;

  const NotificationCard({
    super.key,
    required this.data,
  });

  Future<void> downloadAndOpenPDF(String url) async {
    try {
      final dir = await getTemporaryDirectory();
      final filePath = "${dir.path}/${url.split('/').last}";

      await Dio().download(url, filePath);

      await OpenFile.open(filePath);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // 🔥 TOP ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data['type'] ?? "",
                  style: const TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(),

              // ✅ DATE
              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: Color(0xFF94A3B8),
                  ),

                  const SizedBox(width: 4),

                  Text(
                    data['created_at']
                        .toString()
                        .substring(0, 10),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 10),

              // ✅ PDF BUTTON
              GestureDetector(
                onTap: () {
                  final pdfUrl =
                      "https://bodmaseducation.com/storage/notices/${data['file']}";

                  downloadAndOpenPDF(pdfUrl);
                },

                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.picture_as_pdf_rounded,
                    color: Color(0xFFDC2626),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // ✅ TITLE
          Text(
            data['title'] ?? "",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
              height: 1.3,
            ),
          ),

          const SizedBox(height: 4),

          // ✅ DESCRIPTION
          Text(
            data['description'] ?? "",
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}