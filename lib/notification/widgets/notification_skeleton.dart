import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NotificationSkeleton extends StatelessWidget {
  const NotificationSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  width: 60,
                  color: Colors.white,
                ),
                Container(
                  height: 12,
                  width: 80,
                  color: Colors.white,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // TITLE
            Container(
              height: 16,
              width: double.infinity,
              color: Colors.white,
            ),

            const SizedBox(height: 8),

            // DESC
            Container(
              height: 14,
              width: double.infinity,
              color: Colors.white,
            ),

            const SizedBox(height: 6),

            Container(
              height: 14,
              width: MediaQuery.of(context).size.width * 0.6,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}