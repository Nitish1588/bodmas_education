import 'package:bodmas_education/starts/get_started.dart';
import 'package:flutter/material.dart';
import 'package:bodmas_education/mainmenu/main_menu.dart';
import '../login/services/session.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  //  initApp();
  }

  // void initApp() async {
  //   await PaymentService.fetchAndSaveRazorpayKey();
  // }
  void checkLogin() async {

    await Future.delayed(const Duration(seconds: 1));

    String? token = await Session.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      await Session.getToken();
      await Session.getUser();

      // 🔐 Already Logged In
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainMenu()),
      );

    } else {

      // ❌ Not Logged In
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const GetStarted()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(seconds: 2),
          builder: (context, value, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  begin: Alignment(value * 2 - 1, 0),
                  end: Alignment(-value * 2 + 1, 0),
                  colors: [
                    Colors.blue,
                    Colors.lightBlueAccent,
                    Colors.cyan,
                    Colors.blueAccent,
                  ],
                ).createShader(bounds);
              },
              child: Text(
                "BODMAS EDUCATION",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Colors.blueAccent.withValues(alpha: 0.6),
                      offset: Offset(0, 0),
                    ),
                    Shadow(
                      blurRadius: 30,
                      color: Colors.cyan.withValues(alpha: 0.3),
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            );
          },
          onEnd: () {
            Future.delayed(Duration.zero, () {
              (context as Element).markNeedsBuild();
            });
          },
        ),
      ),
    );
  }
}