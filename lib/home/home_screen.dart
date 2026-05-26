import 'package:bodmas_education/event/event_screen.dart';
import 'package:bodmas_education/home/premium_carousel_widget.dart';
import 'package:bodmas_education/home/quick_blog_section.dart';
import 'package:bodmas_education/home/quick_event.dart';
import 'package:bodmas_education/home/quick_notification_widget.dart';
import 'package:flutter/material.dart';
import '../mainmenu/main_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> imageData = [
    // {"image": "https://picsum.photos/id/1015/800/500"},
    // {"image": "https://picsum.photos/id/1016/800/500"},
    // {"image": "https://picsum.photos/id/1018/800/500"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/vwPGcE6eTnHoj2IWr4UB.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/pSF4wthqIjn02HIwy57O.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/XaxBYaRmARVzxlf3ZTME.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/inhy3sUQiA0JKj4jkolQ.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/vKLz9e9K6byHCxKuoalR.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/C9X210tBLtWYAQUkQyO9.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/QItE5iXNcL1q5v97Yv5S.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/UZuAsJvzNEzDkITXq3iI.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/ADMnbsoGGitC4CKHVrpL.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/l19LSYHNHSTCMqryA9T5.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/Qyas7DWiw7wXYYzSh2EO.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/8x9jFeUdG9VVO5W2NqJ1.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/ZkjFVGIsVGgd6F7yPsuT.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/0C3pkIlpcRtO7Xp4Ko6T.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/Du77nafTQdtyXcLGQ8yup7nwEW4iAoT13CVa6otI.jpg"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/iVxbsuF8udDeLUWEiWEy.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/B57XES7WbkwSeYz4atcy.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/opsHMIrqjg8qHzkfAZIL.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/KVTEjJXLY1OCQhX4uHlA.webp"},
    {"image": "https://bodmaseducation.com/storage/hero_banners/AgoiOQa5gf9QAQSzeaDt.webp"}

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      appBar: AppBar(
        title: const Text("Home")),

      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(1),

        child: Column(
          children: [
            PremiumCarouselWidget(
              data: imageData,
            ),

            const SizedBox(height: 20),

            QuickNotificationSection(
              onViewAll: () {

                /// Navigate Notification Screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainMenu(initialIndex: 5),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),

            QuickBlogSection(
              onViewAll: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainMenu(initialIndex: 6),
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
            QuickEventSection(
              onViewAll: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EventScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      ),
    );
  }
}