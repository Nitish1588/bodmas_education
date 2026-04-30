import 'package:flutter/material.dart';
import 'package:bodmas_education/Mentorship/mentorship.dart';
import 'package:bodmas_education/profile/profile_screen.dart';

/// ✅ MODEL (No more Map errors)
class ServiceModel {
  final String title;
  final IconData icon;
  final Color color;
  final Widget screen;

  ServiceModel({
    required this.title,
    required this.icon,
    required this.color,
    required this.screen,
  });
}

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key});

  /// ✅ CLEAN DATA
  final List<ServiceModel> services = [
    ServiceModel(
      title: "Mentorship",
      icon: Icons.people,
      color: Colors.blue,
      screen: const MentorshipScreen(),
    ),
    ServiceModel(
      title: "Counselling",
      icon: Icons.psychology,
      color: Colors.purple,
      screen: const ProfileScreen(),
    ),
    ServiceModel(
      title: "Meeting",
      icon: Icons.person,
      color: Colors.orange,
      screen: const ProfileScreen(),
    ),
    ServiceModel(
      title: "Mock Test",
      icon: Icons.smart_toy,
      color: Colors.green,
      screen: const ProfileScreen(),
    ),
    ServiceModel(
      title: "Notification",
      icon: Icons.notifications,
      color: Colors.red,
      screen: const ProfileScreen(),
    ),
    ServiceModel(
      title: "Loan",
      icon: Icons.account_balance,
      color: Colors.teal,
      screen: const ProfileScreen(),
    ),
    ServiceModel(
      title: "Cutoff",
      icon: Icons.bar_chart,
      color: Colors.indigo,
      screen: const ProfileScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      /// APPBAR
      appBar: AppBar(
        title: const Text(
          "Services",
        ),
        // centerTitle: true,
        // elevation: 0,
        // flexibleSpace: Container(
        //   decoration: const BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [Color(0xFF4FACFE), Color(0xFF8E54E9)],
        //     ),
        //   ),
        // ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(14),
        child: GridView.builder(
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.25,
          ),
          itemBuilder: (context, index) {
            return _ServiceCard(service: services[index]);
          },
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final ServiceModel service;

  const _ServiceCard({required this.service});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    return GestureDetector(
      onTapDown: (_) => setState(() => scale = 0.93),
      onTapUp: (_) => setState(() => scale = 1),
      onTapCancel: () => setState(() => scale = 1),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => service.screen),
        );
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: scale,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),

            /// OUTER GRADIENT GLOW
            gradient: LinearGradient(
              colors: [
                service.color.withValues(alpha: 0.25),
                service.color.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            boxShadow: [
              BoxShadow(
                color: service.color.withValues(alpha: 0.25),
                blurRadius: 18,
                offset: const Offset(4, 8),
              )
            ],
          ),

          child: Container(
            margin: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// 🔥 ICON CIRCLE
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        service.color.withValues(alpha: 0.25),
                        service.color.withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                  child: Icon(
                    service.icon,
                    size: 32,
                    color: service.color,
                  ),
                ),

                const SizedBox(height: 14),

                /// 📝 TITLE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    service.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}