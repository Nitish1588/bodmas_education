import 'package:bodmas_education/widgets/customwebview_screen.dart';
import 'package:flutter/material.dart';

class EducationLoanScreen extends StatelessWidget {
  // Network Image URL
  final String imageUrl =
      "https://bodmaseducation.com/storage/uploads/1758259268_Importance%20of%20Education%20Loans.png";

  const EducationLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(title: const Text("Education Loan & scholarship")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // TOP IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  // height: 220,
                  width: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),

              const SizedBox(height: 24),

              // TITLE
              const Text(
                "Importance of Education Loans",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1E5BE0),
                ),
              ),

              const SizedBox(height: 10),

              // DESCRIPTION
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Education loans are very important, especially for students desiring to pursue higher education, professional courses, or studies abroad. They can be a real game-changer for many families and students, bridging any gap between financial constraints and academic aspirations.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.7,
                    color: Colors.black87,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // CARDS
              _buildCard(
                borderColor: Colors.blue,
                icon: Icons.school,
                title: "Access to Quality Education",
                titleColor: Colors.blue,
                description:
                    "High tuition fees at top institutions and study abroad programs may not be affordable for every family. "
                    "Education loans help students pursue them based on merit and career goals, not just affordability.",
              ),

              const SizedBox(height: 15),

              _buildCard(
                borderColor: Colors.green,
                icon: Icons.attach_money,
                title: "Financial Flexibility for Families",
                titleColor: Colors.green,
                description:
                    "Paying higher education costs upfront can strain a family’s finances. Education loans spread the cost over"
                    " time, helping avoid selling assets or using savings.",
              ),

              const SizedBox(height: 15),

              _buildCard(
                borderColor: Colors.orange,
                icon: Icons.trending_up,
                title: "Investing in Your Future",
                titleColor: Colors.orange,
                description:
                    "Education loans are an investment that help students gain skills, qualifications, and better career opportunities.",
              ),

              const SizedBox(height: 15),

              _buildCard(
                borderColor: Colors.red,
                icon: Icons.public,
                title: "Supports Higher Studies Abroad",
                titleColor: Colors.red,
                description:
                    "Studying abroad can be expensive due to tuition and living costs. Education loans make it possible by "
                    "supporting international education and better career opportunities.",
              ),

              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomWebViewScreen(
                          url:
                              'https://bodmaseducation.com/services/education-loan-scholarship',
                          title: "Education Loan & Scholarship",
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Read More...',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // ===============================
              // TYPES OF EDUCATION LOANS SECTION
              // ===============================
              const SizedBox(height: 30),

              const Text(
                "Types of Education Loans",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F5EFF),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: .82,
                  children: const [
                    LoanTypeCard(
                      icon: Icons.lock,
                      color: Color(0xff0F5EFF),
                      title: "Secured Loan",
                      subtitle: "Low interest with collateral support",
                    ),

                    LoanTypeCard(
                      icon: Icons.account_balance_wallet,
                      color: Color(0xff1DB954),
                      title: "Unsecured Loan",
                      subtitle: "No collateral needed",
                    ),

                    LoanTypeCard(
                      icon: Icons.flight_takeoff,
                      color: Color(0xffFF9800),
                      title: "Study Abroad",
                      subtitle: "Travel + tuition coverage",
                    ),

                    LoanTypeCard(
                      icon: Icons.account_balance,
                      color: Color(0xffE53935),
                      title: "Govt Loan",
                      subtitle: "Subsidized education support",
                    ),

                    LoanTypeCard(
                      icon: Icons.school,
                      color: Color(0xff7E57C2),
                      title: "Skill Loan",
                      subtitle: "Professional course funding",
                    ),

                    LoanTypeCard(
                      icon: Icons.add_circle,
                      color: Color(0xff00ACC1),
                      title: "Top-Up Loan",
                      subtitle: "Extra financial support",
                    ),
                  ],
                ),
              ),

              // ================================
              // DURATION OF EDUCATION LOANS
              // ================================
              const SizedBox(height: 30),

              const Text(
                "Duration of Education Loans",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F5EFF),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Loan duration includes study period, moratorium and repayment tenure.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: const [
                    DurationCard(
                      color: Color(0xff0F5EFF),
                      icon: Icons.menu_book_rounded,
                      title: "Study Period",
                      subtitle: "Course duration with partial EMI",
                    ),

                    SizedBox(height: 14),

                    DurationCard(
                      color: Color(0xff1DB954),
                      icon: Icons.hourglass_bottom_rounded,
                      title: "Grace Period",
                      subtitle: "6-12 months after course completion",
                    ),

                    SizedBox(height: 14),

                    DurationCard(
                      color: Color(0xffFF9800),
                      icon: Icons.credit_card,
                      title: "Repayment",
                      subtitle: "EMI repayment for 5-15 years",
                    ),
                  ],
                ),
              ),

              // ================================
              // FACTORS AFFECTING DURATION
              // ================================
              const SizedBox(height: 30),

              const Text(
                "Factors Affecting Duration",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F5EFF),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.15,
                  children: const [
                    FactorCard(
                      color: Color(0xff0F5EFF),
                      icon: Icons.attach_money,
                      title: "Loan Amount",
                    ),

                    FactorCard(
                      color: Color(0xff1DB954),
                      icon: Icons.school,
                      title: "Course Type",
                    ),

                    FactorCard(
                      color: Color(0xffFF9800),
                      icon: Icons.account_balance,
                      title: "Bank Policies",
                    ),

                    FactorCard(
                      color: Color(0xffE53935),
                      icon: Icons.bar_chart,
                      title: "Income Potential",
                    ),
                  ],
                ),
              ),

              // ================================
              // INTEREST OF EDUCATION LOANS
              // ================================
              const SizedBox(height: 30),

              const Text(
                "Interest of Education Loans",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F5EFF),
                ),
              ),

              const SizedBox(height: 5),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  "Education loans offer fixed and floating interest rates.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: const [
                    InterestCard(
                      color: Color(0xff0F5EFF),
                      icon: Icons.push_pin,
                      title: "Fixed Interest",
                      subtitle: "Stable EMI throughout tenure",
                    ),

                    SizedBox(height: 14),

                    InterestCard(
                      color: Color(0xff1DB954),
                      icon: Icons.show_chart,
                      title: "Floating Interest",
                      subtitle: "Rates change with market trends",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Factors Affecting Interest",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F5EFF),
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.1,
                  children: const [
                    SmallInterestCard(icon: Icons.lock, title: "Loan Type"),

                    SmallInterestCard(icon: Icons.home, title: "Collateral"),

                    SmallInterestCard(icon: Icons.people, title: "Co-Applicant",),

                    SmallInterestCard(icon: Icons.school, title: "Institution"),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomWebViewScreen(
                          url:
                              'https://bodmaseducation.com/services/education-loan-scholarship',
                          title: "Education Loan & Scholarship",
                        ),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),

                  child: const Text(
                    'Read More...',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildCard({
    required Color borderColor,
    required IconData icon,
    required String title,
    required Color titleColor,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: borderColor, width: 3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: titleColor, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class LoanTypeCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const LoanTypeCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ICON
          Container(
            height: 62,
            width: 62,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),

          const SizedBox(height: 10),

          // TITLE
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 5),

          // SUBTITLE
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              height: 1.2,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================
// DURATION CARD
// ================================

class DurationCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  const DurationCard({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border(left: BorderSide(color: color, width: 5)),
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================
// FACTOR CARD
// ================================

class FactorCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;

  const FactorCard({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 32),

          const SizedBox(height: 12),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ================================
// INTEREST CARD
// ================================

class InterestCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;

  const InterestCard({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border(left: BorderSide(color: color, width: 5)),
      ),
      child: Row(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================
// SMALL INTEREST CARD
// ================================

class SmallInterestCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const SmallInterestCard({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFDEE8FA),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xff0F5EFF), size: 30),

          const SizedBox(height: 10),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xff0F5EFF),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
