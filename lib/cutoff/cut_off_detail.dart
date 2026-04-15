import 'package:flutter/material.dart';

class CutoffDetailScreen extends StatelessWidget {
  final String title;
  final String price;
  final String image;

  const CutoffDetailScreen({
    super.key,
    required this.title,
    required this.price,
    required this.image,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),

      /// 🔻 BOTTOM BUTTON
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Color(0xFFFFFFFF),
            backgroundColor: Color(0xFF3B81F4),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {},
          child: Text(
            "Pay Now $price",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),

      appBar: AppBar(
        title: const Text("DASA (NIT)"),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔥 TOP IMAGE WITH OVERLAY
            Stack(
              children: [
                Image.network(
                  image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.6),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    "$title Cut-Off 2025",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),

            /// 🔻 CONTENT
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// PRICE BOX
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(fontWeight: FontWeight.w500,
                            fontSize: 18),
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// DESCRIPTION TITLE
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// DESCRIPTION TEXT
                  const Text(
                    "The amount is non-refundable after purchase. If you face any issues with your purchase, please contact 93112 09952.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}