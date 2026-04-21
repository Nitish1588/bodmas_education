import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../blog_detail_screen.dart';

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

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),

      child: Padding(
        padding: const EdgeInsets.all(8),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                "https://bodmaseducation.com/images/feature/${blog["feature_image"]}",
                height: 75,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 5),

            /// TITLE
            Text(
              blog["title"] ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 5),

            /// AUTHOR + DATE
            Row(
              children: [
                const Icon(Icons.person, size: 14, color: Color(0xFF666666)),
                const SizedBox(width: 4),

                // Author text flexible
                Expanded(
                  flex: 2,
                  child: Text(
                    blog["author"] ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                const Icon(Icons.calendar_today,
                    size: 14, color: Color(0xFF666666)),

                const SizedBox(width: 4),

                // Date text flexible
                Flexible(
                  flex: 1,
                  child: Text(
                    date,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ],
            ),

           const Spacer(),

            /// READ MORE BUTTON
            SizedBox(
              width: double.infinity,
              height: 30,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: const Color(0xFFFFFFFF),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlogDetailScreen(blog: blog),
                      ),
                    );
                  },

                  child: const Text(
                    "Read More",
                    style: TextStyle(fontSize: 12),
                  ),
                ),

            )
          ],
        ),
      ),
    );
  }
}