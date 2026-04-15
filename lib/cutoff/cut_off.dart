import 'package:bodmas_education/notification/notification_screen.dart';
import 'package:flutter/material.dart';

class CutOffScreen extends StatefulWidget {
  const CutOffScreen({super.key});

  @override
  State<CutOffScreen> createState() => _CutOffScreenState();
}

class _CutOffScreenState extends State<CutOffScreen> {

  List<bool> expandedList = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(
        title: const Text("Cut-Off"),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(

          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image (Top)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/notification.webp', // change path if needed
                      //width: double.infinity,
                      //height: 200,
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  SizedBox(height: 10),

                  // Title
                  Text(
                    "State Wise NEET, MBBS & Engineering Paid Cutoff 2023–2025",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),

                  SizedBox(height: 8),

                  // Description
                  Text(
                    "Understanding the NEET cutoff and engineering admission cutoffs is one of the most critical steps in securing admission to top colleges in India. Every year, thousands of students struggle to analyze previous year cutoff trends, state quota variations, government vs private college differences, and round-wise changes. To make this process simple and data-driven,"
                        " Bodmas Education provides verified state-wise paid cutoff data for MBBS, BDS, NIT, IIIT, GFTI and other counselling authorities.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 6),

                  // Text(
                  //   "Over the years, Ashok Sir has guided aspirants across fields like medical (NEET-UG, AIIMS, state medical counseling), engineering (JEE Main, JEE Advanced, private and deemed university admissions), law (CLAT, AILET), and management (CUET, IPMAT, SET).",
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     height: 1.5,
                  //     color: Colors.black87,
                  //   ),
                  // ),
                ],
              ),
            ),
            /// 🔍 FILTER SECTION xz
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _dropdown("Course")),
                      const SizedBox(width: 10),
                      Expanded(child: _dropdown("State")),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      label: const Text("Search Cutoff"),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 🔴 PREMIUM CARDS
            _premiumCard(
              index: 0,
              title: "DASA (SFTI)",
              price: "₹49",
              oldPrice: "₹99",
              image:
              "https://bodmaseducation.com/images/package/264ce6a6-7832-4651-89cf-2a0d4174d4b6.png",
            ),

            _premiumCard(
              index: 1,
              title: "DASA (NIT)",
              price: "₹99",
              oldPrice: "₹149",
              image:
              "https://bodmaseducation.com/images/package/ef070812-3888-4146-8f3d-30897a637763.png",
            ),

            _premiumCard(
              index: 2,
              title: "DASA (IIIT)",
              price: "₹99",
              oldPrice: "₹149",
              image:
              "https://bodmaseducation.com/images/package/3629f0d9-4aed-4647-92d8-b19c59a9b771.png",
            ),
          ],
        ),
      ),
    );
  }

  /// 🔽 DROPDOWN
  Widget _dropdown(String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: Colors.white,
          iconEnabledColor: Colors.white,
          hint: Text(
            hint,
            style: const TextStyle(color: Colors.white),
          ),
          items: const [
            DropdownMenuItem(value: "1", child: Text("Engineering")),
            DropdownMenuItem(value: "2", child: Text("Medical")),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }

  /// 🔥 PREMIUM CARD
  Widget _premiumCard({
    required int index,
    required String title,
    required String price,
    required String oldPrice,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFFF1FCFF), Color(0xFFFFFFFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withValues(alpha: 0.3),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [

          /// IMAGE + BADGE
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
                child: Image.network(
                  image,
                  //height: 290,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),

              /// PRICE BADGE
              Positioned(
                right: 10,
                top: 10,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFBFF2FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "ONLY $price",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 12),

          /// TITLE
          // Text(
          //   "$title Cut-Off 2025",
          //   style: const TextStyle(
          //     color: Color(0xFF2663E9),
          //     fontSize: 18,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),

          const SizedBox(height: 6),

          /// PRICE ROW
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0,0.0,12.0,0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    "$title Cut-Off 2025",
                    style: const TextStyle(
                      color: Color(0xFF2663E9),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  oldPrice,
                  style: const TextStyle(
                    color: Colors.red,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          if (expandedList[index])
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "This package includes complete cutoff data for $title including round-wise trends, category-wise ranks, and previous year analysis.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          const SizedBox(height: 5),

          /// BUTTONS
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0,5.0,8.0,0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: _btn("View Details", () {
                    setState(() {
                      expandedList[index] = !expandedList[index];
                    });
                  }),
                ),
                const SizedBox(width: 10),
                Expanded(child: _btn("Pay Now", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotificationScreen()),
                  );
                }),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),
        ],
      ),
    );
  }

  Widget _btn(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFFAA0),
            Color(0xFFFFF176), // slight darker shade for depth
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 1, horizontal: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: Colors.red.shade700,
          ),
        ),
      ),
    );
  }
}


