import 'package:bodmas_education/blog/blog_screen.dart';
import 'package:bodmas_education/cutoff/cut_off.dart';
import 'package:bodmas_education/education_loan_screen.dart';
import 'package:bodmas_education/home/home_screen.dart';
import 'package:bodmas_education/meeting/meeting_screen.dart';
import 'package:bodmas_education/notification/notification_screen.dart';
import 'package:bodmas_education/profile/profile_screen.dart';
import 'package:bodmas_education/service/service.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  final int initialIndex;

  const MainMenu({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  final List<Widget> screens = [
    HomeScreen(),
    ServicesScreen(),
    MeetingScreen(),
    CutOffScreen(),
    EducationLoanScreen(),
    NotificationScreen(),
    BlogScreen(),
    ProfileScreen(),
    //const Center(child: Text("Profile Screen")),
  ];

  final List<MenuItemModel> menuItems = [
    MenuItemModel(icon: Icons.home, label: "Home"),
    MenuItemModel(icon: Icons.miscellaneous_services, label: "Services"),
    MenuItemModel(icon: Icons.video_call, label: "121 session"),
    MenuItemModel(icon: Icons.school, label: "Cut-off"),
    MenuItemModel(icon: Icons.cast_for_education, label: "Loan"),
    MenuItemModel(icon: Icons.notifications, label: "Notification"),
    MenuItemModel(icon: Icons.article, label: "Blog"),
    MenuItemModel(icon: Icons.person, label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedIndex == 0, // only home can exit
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && selectedIndex != 0) {
          setState(() {
            selectedIndex = 0; // go to home first
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFBFDFF),
        body: IndexedStack(index: selectedIndex, children: screens),

        bottomNavigationBar: CustomNavBar(
          selectedIndex: selectedIndex,
          items: menuItems,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

/// MODEL
class MenuItemModel {
  final IconData icon;
  final String label;

  MenuItemModel({required this.icon, required this.label});
}

/// CUSTOM NAVBAR
class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<MenuItemModel> items;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final ScrollController scrollController = ScrollController();

    return SafeArea(

      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: width * 0.01,
         // vertical: width * 0.02,
        ),
        padding: EdgeInsets.symmetric(vertical: width * 0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(width * 0.04),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
            ),
          ],
        ),
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true, // always visible
          trackVisibility: false,
          thickness: 4,
          radius: Radius.circular(20),
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(), // smooth feel
            child: Row(
              children: List.generate(items.length, (index) {
                final isSelected = selectedIndex == index;
                final item = items[index];

                return GestureDetector(
                  onTap: () => onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: width * 0.015),
                    padding: EdgeInsets.symmetric(
                      horizontal: isSelected ? width * 0.04 : width * 0.025,
                      vertical: width * 0.015,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                Colors.blue.withValues(alpha: 0.25),
                                Colors.blue.withValues(alpha: 0.05),
                              ],
                            )
                          : null,
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedScale(
                          scale: isSelected ? 1.15 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: Icon(
                            item.icon,
                            size: width * 0.06,
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: width * 0.008),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: width * 0.028,
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade600,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
