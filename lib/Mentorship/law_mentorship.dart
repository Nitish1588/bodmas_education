import 'package:flutter/material.dart';
import '../widgets/customwebview_screen.dart';

class LawMentorshipScreen extends StatefulWidget {
  const LawMentorshipScreen({super.key});

  @override
  State<LawMentorshipScreen> createState() => _LawMentorshipScreenState();
}

class _LawMentorshipScreenState extends State<LawMentorshipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(
        title: const Text("Mentorship Program for Law"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/Lawmentorship.webp',
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    "Mentorship Program for Law Aspirants",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Description
                  const Text(
                    "Bodmas Education offers comprehensive mentorship programs for law aspirants, providing expert guidance and "
                        "personalized support to help students navigate their legal education and career paths. Our mentorship programs "
                        "cater to students pursuing BA LLB, B.Com LLB, BBA LLB, and LLB courses. With experienced mentors, strategic academic "
                        "planning, and career counseling, we equip students with the knowledge and skills needed to excel in the legal field.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    "Empowering Medical Aspirants",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Description
                  const Text(
                    "Whether you're preparing for CLAT or other law entrance exams, exam preparation can be overwhelming. Bodmas "
                        "Education's mentors help students create customized study plans that fit their needs, strengths, and timelines.\n"
                        "✓ Expert Study Techniques\n"
                        "✓ Time Management Strategies\n"
                        "✓ Stress Management",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),


                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B81F4),
                        foregroundColor: const Color(0xFFFFFFFF), // White text
                      ),
                      child: const Text("Read More..."),
                      onPressed: () async {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CustomWebViewScreen(
                              url:
                              'https://bodmaseducation.com/mentorship/mentorship-program-for-law',
                              title: "Mentorship Program for Law",
                            ),
                          ),
                        );

                      },
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

