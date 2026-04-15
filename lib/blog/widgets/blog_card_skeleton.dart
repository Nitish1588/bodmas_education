import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BlogCardSkeleton extends StatelessWidget {
  const BlogCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade300, // 👈 parent grey
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 TITLE
            Container(
              height: 16,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white, // 👈 White
                borderRadius: BorderRadius.circular(6),

              ),
            ),

            const SizedBox(height: 10),

            // 🔹 DESCRIPTION LINE 1
            Container(
              height: 14,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),

            const SizedBox(height: 6),

            // 🔹 DESCRIPTION LINE 2
            Container(
              height: 14,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 DATE
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 12,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}