import 'package:flutter/material.dart';

class CutoffHeader extends StatelessWidget {
  const CutoffHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/notification.webp',
            fit: BoxFit.fitWidth,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          "State Wise NEET, MBBS & Engineering Paid Cutoff 2023–2025",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B82F6),
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          "Understanding the NEET cutoff and engineering admission cutoffs is one of the most critical steps in securing admission to top "
              "colleges in India. Every year, thousands of students struggle to analyze previous year cutoff trends, state quota variations,"
              " government vs private college differences, and round-wise changes. To make this process simple and data-driven,"
              " Bodmas Education provides verified state-wise paid cutoff data for MBBS, BDS, NIT, IIIT, GFTI and other counselling "
              "authorities.",
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}