import 'package:flutter/material.dart';
import '../login/login_screen.dart';
import 'dart:async';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  late Timer _timer;

  // Images and their corresponding text
  final List<Map<String, String>> sliderItems = [
    {
      "image": "assets/images/img.png",
      "title": "Welcome to Bodmas Education",
      "description": "Your go-to app for all your learning needs",
    },
    {
      "image": "assets/images/img.png",
      "title": "Structured Content",
      "description": "Access study material that is structured to help you succeed",
    },
    {
      "image": "assets/images/img.png",
      "title": "It's all about communication",
      "description": "Stay connected 24x7 directly using our chat feature",
    },
  ];

  @override
  void initState() {
    super.initState();

    // Auto-slide every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = currentIndex + 1;
      if (nextPage >= sliderItems.length) {
        nextPage = 0;
      }
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// IMAGE + TEXT SLIDER
            SizedBox(
              height: 300,
              width: double.infinity,
              child: PageView.builder(
                controller: _controller,
                itemCount: sliderItems.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Image.asset(
                          sliderItems[index]["image"]!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        sliderItems[index]["title"]!,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        sliderItems[index]["description"]!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            /// DOT INDICATOR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(sliderItems.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 10 : 6,
                  height: currentIndex == index ? 10 : 6,
                  decoration: BoxDecoration(
                    color: currentIndex == index ? Color(0xFF4CAF50) : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),

            const SizedBox(height: 30), // 30px below the indicator

            /// GET STARTED BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50), // Green background
                  foregroundColor: const Color(0xFFFFFFFF), // White text
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                child: const Text("Get Started"),
              ),
            )
          ],
        ),
      ),
    );
  }}