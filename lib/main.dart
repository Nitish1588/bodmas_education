import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cutoff/service/payment_service.dart';
import 'notification-service.dart';
import 'starts/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  PaymentService.fetchAndSaveRazorpayKey();
  await NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1557D6),
          titleTextStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
