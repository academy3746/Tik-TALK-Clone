import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/auth/sign_up_screen.dart';
import 'package:tictok_clone/features/onboarding/interests_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tik-TALK! Clone',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: const Color(0xFFE9435A),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size20 - Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const InterestsScreen(),
    );
  }
}
