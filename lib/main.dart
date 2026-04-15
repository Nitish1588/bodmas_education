import 'package:flutter/material.dart';
import 'starts/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF4BAE4F),
          titleTextStyle: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(color: Color(0xFFFFFFFF),),

        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}