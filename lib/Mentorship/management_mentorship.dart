import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagementMentorshipScreen extends StatefulWidget {
  const ManagementMentorshipScreen({super.key});

  @override
  State<ManagementMentorshipScreen> createState() => _ManagementMentorshipScreenState();
}

class _ManagementMentorshipScreenState extends State<ManagementMentorshipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(
        title: const Text("Mentorship Program for Management"),
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
                    "Mentorship Program for Management",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Description
                  const Text(
                    "Bodmas Education offers specialized mentorship programs for management aspirants, providing expert guidance and "
                        "strategic career planning to help students excel in the dynamic field of management. Our programs support students "
                        "pursuing BBA, BMS, BHM, Integrated BBA-MBA, and Fashion & Design courses. With experienced mentors, personalized "
                        "counseling, and industry insights, we ensure that students gain the necessary skills, knowledge, and confidence to "
                        "succeed in their academic journey and professional careers.",
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
                    "Getting into a top management institute requires strategic preparation. Our mentors provide comprehensive support "
                        "tailored to your needs.\n"
                        "✓ Customized Study Plans\n"
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
                          'https://bodmaseducation.com/mentorship/mentorship-program-for-management',
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

