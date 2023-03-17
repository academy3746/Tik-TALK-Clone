import 'package:flutter/material.dart';

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
      ),
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }
}
