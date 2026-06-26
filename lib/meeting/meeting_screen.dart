import 'package:bodmas_education/meeting/meeting_form_screen.dart';
import 'package:flutter/material.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(
        title: const Text("Meeting"),

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      'assets/images/profile/ashok_kumar.jpg', // change path if needed
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 10),

                  // Title
                  Text(
                    "About Ashok Sir - The Chief Mentor",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),

                  SizedBox(height: 8),

                  // Description
                  Text(
                    "Mr. Ashok Kumar, Founder and CEO of Bodmas Education Services, has over two decades of experience in the education and career consultancy sector. Having mentored thousands of students from diverse academic backgrounds, he is known for his data-driven approach, intuitive understanding of student psychology, and unparalleled knowledge of India's admission ecosystem.",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Over the years, Ashok Sir has guided aspirants across fields like medical (NEET-UG, AIIMS, state medical counseling), engineering (JEE Main, JEE Advanced, private and deemed university admissions), law (CLAT, AILET), and management (CUET, IPMAT, SET).",
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            /// 💡 Philosophy
            const Text(
              "His Mentorship Philosophy",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _SmallCard(
                  title: "Clarity",
                  icon: Icons.lightbulb_outline,
                ),
                _SmallCard(
                  title: "Confidence",
                  icon: Icons.fitness_center,
                ),
                _SmallCard(
                  title: "Consistency",
                  icon: Icons.track_changes,
                ),

              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MeetingFormScreen()),
                  );
                },
                child: const Text(
                  "Click Here to Book Meeting",
                  textAlign: TextAlign.center,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),


            SizedBox(height: 15),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                "Key Focus Areas Covered in the Meetings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B82F6),
                ),
              ),

              SizedBox(height: 8),

              // Subtitle
              Text(
                "The discussions are structured to bring out the maximum value for students across all academic stages. Depending on the student's profile, Ashok Sir addresses:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),

              SizedBox(height: 16),

              // Cards Grid
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _card("Entrance Exam Strategy",
                      "Which exams to prioritize, how to distribute effort, and how to align school and competitive preparation"),

                  _card("Application Planning",
                      "Timelines for filling forms, managing multiple exams, and preventing documentation errors"),

                  _card("Counselling Insights",
                      "Understanding AIQ vs. State Quota, Deemed Universities, and private college options"),

                  _card("Cutoff Analysis",
                      "Realistic assessment of college options based on prior years' trends and expected performance"),

                  _card("Course-College Selection Guidance",
                      "Guidance to choose between programs and also between colleges"),

                  _card("Scholarship and Financial Planning",
                      "Guidance on merit-based or government scholarship schemes and education loan support"),

                  _card("Motivational Guidance",
                      "Mental readiness, confidence building, and stress management techniques"),
                ],
              ),

              SizedBox(height: 12),

              // Footer line
              Text(
                "Each interaction ensures students receive clarity, direction, and confidence in their decision-making.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ],
          ),
        ),


            const SizedBox(height: 20),
            /// 🎯 Benefits
            const Text(
              "Why Meet Ashok Sir?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: const [
                _BenefitCard(title: "Personal Attention", icon: Icons.person),
                _BenefitCard(title: "College Mapping", icon: Icons.map),
                _BenefitCard(title: "Admission Strategy", icon: Icons.assignment),
                _BenefitCard(title: "Parental Clarity", icon: Icons.family_restroom),
                _BenefitCard(title: "Confidence Build", icon: Icons.trending_up),
                _BenefitCard(title: "Long-Term Vision", icon: Icons.flag),
              ],
            ),

            const SizedBox(height: 1),

            /// 🔥 Highlight Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3B82F6),
                    Color(0xFF6366F1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.timer, color: Colors.white),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Save time & effort with expert planning",
                      style: TextStyle(color: Colors.white),
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




class _BenefitCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _BenefitCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 25, color: Color(0xFF3B82F6)),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 13),
          ),
        ],
      ),
    );
  }
}



class _SmallCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SmallCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 42) / 3.1,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icon, color: Color(0xFF3B82F6)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize:11,fontWeight: FontWeight.bold)),
        ],
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