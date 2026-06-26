import 'package:bodmas_education/event/event_screen.dart';
import 'package:bodmas_education/home/carousel/premium_carousel_widget.dart';
import 'package:bodmas_education/home/quick_blog_section.dart';
import 'package:bodmas_education/home/quick_event.dart';
import 'package:bodmas_education/home/quick_notification_widget.dart';
import 'package:flutter/material.dart';
import '../mainmenu/main_menu.dart';
import 'carousel/carousel_model.dart';
import 'carousel/carousel_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CarouselModel> banners = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadBanners();
  }

  Future<void> loadBanners() async {
    try {
      banners = await CarouselService.fetchBanners();
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFDFF),
      //appBar: AppBar(title: const Text("Home")),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.webp',
              height: 40,
            ),
            // const SizedBox(width: 10),
            // const Text("Home"),
          ],
        ),
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(1),

          child: Column(
            children: [
              isLoading
                  ? const SizedBox(
                      height: 150,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : PremiumCarouselWidget(data: banners),

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
                    MaterialPageRoute(builder: (_) => const EventScreen()),
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
