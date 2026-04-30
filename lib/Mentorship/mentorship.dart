import 'package:bodmas_education/Mentorship/engg_mentorship.dart';
import 'package:bodmas_education/Mentorship/law_mentorship.dart';
import 'package:bodmas_education/Mentorship/management_mentorship.dart';
import 'package:bodmas_education/Mentorship/medical_mentorship.dart';
      import 'package:flutter/material.dart';

class MentorshipScreen extends StatefulWidget {
  const MentorshipScreen({super.key});

  @override
  State<MentorshipScreen> createState() => _MentorshipScreenState();
}

class _MentorshipScreenState extends State<MentorshipScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(
        title: const Text("Admission Mentorship Program"),
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
                      'assets/images/mentorship.webp',
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    "Difference B/W Mentorship, Teaching, Counselling, Coaching",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Description
                  const Text(
                    "Mentorship, counselling, teaching, and coaching are different roles. Teaching gives knowledge, coaching builds "
                        "performance for exams, counselling helps with current academic or career decisions, and mentorship focuses on "
                        "long-term personal and career growth through guidance and experience sharing.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    "Importance of Mentors",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Description
                  const Text(
                    "Most great achievers had mentors who guided them during their journey to success. A mentor usually works closely with"
                        " one mentee, helping shape their career and open new opportunities. Mentors share experience, give advice, and connect"
                        " mentees to the right opportunities. According to the International Coaching Federation, a mentor is an expert who "
                        "offers wisdom and guidance based on personal experience, which may include advising, counselling, and coaching.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),


                  const SizedBox(height: 10),

                  mentorshipGrid(context),

                  const SizedBox(height: 10),

                  // Title
                  const Text(
                    "What Students Will Gain",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Cards Grid
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _card("Enrollment In Mentorship Program",
                          "Students enroll in the mentorship program to begin their guided journey."),

                      _card("Personalized Sessions with Ashok Sir",
                          "One-on-one interaction to understand the student's background, strengths, and challenges."),

                      _card("Dedicated notification alert",
                          "Service ensuring that students get real-time updates."),

                      _card("Mock Test & Detail Analysis",
                          "Regular assessments followed by detailed analysis to identify areas of improvement."),

                      _card("Performance Tracking",
                          "Continuous monitoring of progress with feedback and corrective strategies."),

                      _card("Post-result & Admission Guidance",
                          "Support in choosing the right course, college, and career pathway after results."),

                      _card("Last 3 Year Cutoff",
                          "And Trend analysis for college selection"),
                    ],
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



// ---- card widget
Widget _card(String title, String desc) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(10),
      border: Border(
        left: BorderSide(color: Color(0xFF3B82F6), width: 3),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3B82F6),
          ),
        ),
        SizedBox(height: 3),
        Text(
          desc,
          style: TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    ),
  );
}
Widget mentorshipGrid(BuildContext context) {
  final items = [
    {
      "title": "MEDICAL",
      "icon": Icons.medical_services,
      "page": MedicalMentorshipScreen(),
      "colors": [Color(0xFF4FACFE), Color(0xFF00F2FE)],
    },
    {
      "title": "ENGINEERING",
      "icon": Icons.settings,
      "page": EnggMentorshipScreen(),
      "colors": [Color(0xFF43E97B), Color(0xFF38F9D7)],
    },
    {
      "title": "LAW",
      "icon": Icons.balance,
      "page": LawMentorshipScreen(),
      "colors": [Color(0xFFFFA17F), Color(0xFFFF6A88)],
    },
    {
      "title": "MANAGEMENT",
      "icon": Icons.work,
      "page": ManagementMentorshipScreen(),
      "colors": [Color(0xFF667EEA), Color(0xFF764BA2)],
    },
  ];

  return Column(
    children: [
      const SizedBox(height: 10),

      const Text(
        "Bodmas Mentorship Program",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1E3A8A),
        ),
      ),

      const SizedBox(height: 18),

      GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.3,
        ),
        itemBuilder: (context, index) {
          final item = items[index];

          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => item["page"] as Widget),
              );
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: (item["colors"] as List<Color>),
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (item["colors"] as List<Color>)[0].withValues(alpha: 0.5),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// ICON
                  Icon(
                    item["icon"] as IconData,
                    color: Colors.white,
                    size: 34,
                  ),

                  const SizedBox(height: 10),

                  /// TITLE
                  Text(
                    item["title"] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ],
  );
}