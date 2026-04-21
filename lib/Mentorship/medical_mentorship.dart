import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MedicalMentorshipScreen extends StatefulWidget {
  const MedicalMentorshipScreen({super.key});

  @override
  State<MedicalMentorshipScreen> createState() => _MedicalMentorshipScreenState();
}

class _MedicalMentorshipScreenState extends State<MedicalMentorshipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(
        title: const Text("Mentorship Program for NEET UG"),
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
                      'assets/images/Medicalmentorship.webp',
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    "Mentorship Program for NEET UG",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Description
                  const Text(
                    "Bodmas Education offers dedicated mentorship programs for medical aspirants, guiding students through every stage of"
                        " their academic and professional journey. These programs are designed for students pursuing MBBS, BDS, BHMS, BUMS,"
                        " Veterinary, Nursing, and Pharmacy. With expert mentors and personalized guidance, we help students excel in their "
                        "education and future careers, from preparing for entrance exams to navigating the competitive admissions process.",
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
                    "Bodmas Education offers dedicated mentorship programs for medical aspirants, guiding students through every stage "
                        "of their academic and professional journey.\n"
                        "✓ MBBS, BDS, BHMS, BUMS Programs\n"
                        "✓ Veterinary, Nursing, and Pharmacy\n"
                        "✓ Expert Mentors & Personalized Guidance",
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
                          'https://bodmaseducation.com/mentorship/mentorship-program-for-medical',
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

