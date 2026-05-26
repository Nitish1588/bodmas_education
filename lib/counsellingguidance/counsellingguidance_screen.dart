import 'package:bodmas_education/counsellingguidance/widget/counselling_package_card.dart';
import 'package:flutter/material.dart';

class CounsellingGuidanceScreen extends StatelessWidget {
  const CounsellingGuidanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(title: const Text("Counselling Guidance")),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          /// REUSABLE CARD
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/1.webp",
            courseName: "MBBS",
            price: "₹50,000",
            gst: "₹9,000",
            total: "₹59,000",
            link: "https://bodmaseducation.com/paid-guidance-mbbs",
          ),

          //   SizedBox(height: 18),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/2.webp",
            courseName: "MD/MS",
            price: "₹70,000",
            gst: "₹12,600",
            total: "₹82,600",
            link: "https://bodmaseducation.com/paid-guidance-md-ms",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/3.webp",
            courseName: "Dental",
            price: "₹20,000",
            gst: "₹3,600.00",
            total: "₹23,600.00",
            link: "https://bodmaseducation.com/paid-guidance-dental",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/4.webp",
            courseName: "Ayush",
            price: "₹20,000",
            gst: "₹3,600.00",
            total: "₹23,600.00",
            link: "https://bodmaseducation.com/paid-guidance-ayush",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/5.webp",
            courseName: "Veterinary",
            price: "₹40,000",
            gst: "₹7,200.00",
            total: "₹47,200.00",
            link: "https://bodmaseducation.com/paid-guidance-veterinary",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/6.webp",
            courseName: "Nursing",
            price: "₹10,000",
            gst: "₹1,800.00",
            total: "₹11,800.00",
            link: "https://bodmaseducation.com/paid-guidance-nursing",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/7.webp",
            courseName: "Engineering",
            price: "₹25,000",
            gst: "₹4,500.00",
            total: "₹29,500.00",
            link: "https://bodmaseducation.com/paid-guidance-engineering",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/8.webp",
            courseName: "Law & Management",
            price: "₹25,000",
            gst: "₹4,500.00",
            total: "₹29,500.00",
            link: "https://bodmaseducation.com/law-management",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/9.webp",
            courseName: "DM/MCH",
            price: "₹25,000",
            gst: "₹4,500.00",
            total: "₹29,500.00",
            link: "https://bodmaseducation.com/dm-mch",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/10.webp",
            courseName: "MDS",
            price: "₹30,000",
            gst: "₹5,400.00",
            total: "₹35,400.00",
            link: "https://bodmaseducation.com/mds-paid-guidance",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/11.webp",
            courseName: "INI CET",
            price: "₹25,000",
            gst: "₹4,500.00",
            total: "₹29,500.00",
            link: "https://bodmaseducation.com/ini-cet",
          ),
          CounsellingPackageCard(
            image: "assets/images/counselling-guidance/12.webp",
            courseName: "DNB/MPH/MHA/2 Years Diploma",
            price: "₹50,000",
            gst: "₹9,000.00",
            total: "₹59,000.00",
            link: "https://bodmaseducation.com/dnb-mph-mha-2-years-deploma",
          ),
        ],
      ),
    );
  }
}
