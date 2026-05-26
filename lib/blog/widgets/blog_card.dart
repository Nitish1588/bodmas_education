import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../blog_webview_screen.dart';

class BlogCard extends StatelessWidget {
  final Map blog;
  const BlogCard({super.key, required this.blog});
  @override
  Widget build(BuildContext context) {
    String date = "";
    if (blog["published_at"] != null) {
      DateTime dt = DateTime.parse(blog["published_at"]);
      date = DateFormat("dd MMM yy").format(dt);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 BLOG IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                "https://bodmaseducation.com/images/feature/${blog["feature_image"]}",
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 8),

            /// 🔥 TITLE
            Text(
              blog["title"] ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
                height: 1.2,
              ),
            ),

            const SizedBox(height: 4),

            /// 🔥 AUTHOR + DATE
            Row(
              children: [
                // AUTHOR
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    size: 10,
                    color: Color(0xFF2563EB),
                  ),
                ),

                const SizedBox(width: 4),

                Expanded(
                  child: Text(
                    blog["author"] ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),

                const SizedBox(width: 5),

                // DATE
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    size: 10,
                    color: Color(0xFF2563EB),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),

            const Spacer(),

            /// 🔥 READ MORE BUTTON
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  final slug = blog["slug"];
                  final url = "https://bodmaseducation.com/blog_details/$slug";
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlogWebViewScreen(
                        url: url,
                        title: blog["title"] ?? "Blog",
                      ),
                    ),
                  );
                },

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.auto_stories_rounded, size: 16),
                    SizedBox(width: 8),
                    Text(
                      "Read More",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
