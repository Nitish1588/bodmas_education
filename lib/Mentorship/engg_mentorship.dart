import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EnggMentorshipScreen extends StatefulWidget {
  const EnggMentorshipScreen({super.key});

  @override
  State<EnggMentorshipScreen> createState() => _EnggMentorshipScreenState();
}

class _EnggMentorshipScreenState extends State<EnggMentorshipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(
        title: const Text("Mentorship program For JEE"),
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
                      'assets/images/enggmentorship.webp',
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    "Mentorship Program for Engineering",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Description
                  const Text(
                    "Bodmas Education offers a structured mentorship program for engineering aspirants, guiding them through every step "
                        "of their academic and professional journey. Our mentorship covers various engineering disciplines, including B.Tech, "
                        "B.E., and Integrated B.Tech - M.Tech programs, ensuring students receive expert guidance in their chosen fields. With"
                        " personalized counseling, strategic career planning, and insights into the latest technological advancements, our"
                        " mentors help students excel in entrance exams, choose the right specialization, and prepare for industry challenges."
                        " From preparing for entrance exams to navigating the competitive admissions process and excelling in engineering "
                        "studies, every step requires expert guidance and support.",
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
                    "Whether preparing for JEE Main or JEE Advanced, exam preparation can be overwhelming. Bodmas Education's mentors help students "
                        "create customized study plans tailored to their needs, strengths, and timelines.\n"
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
                        backgroundColor: const Color(0xFF3B81F4), // Green background
                        foregroundColor: const Color(0xFFFFFFFF), // White text
                      ),
                      child: const Text("Read More..."),
                      onPressed: () async {
                        final Uri url = Uri.parse(
                          'https://bodmaseducation.com/mentorship/mentorship-program-for-engineering',
                        );

                        try {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        } catch (e) {
                          //print('Error: $e');
                        }
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

