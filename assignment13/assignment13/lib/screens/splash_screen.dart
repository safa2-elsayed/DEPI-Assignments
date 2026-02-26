import 'package:flutter/material.dart';
import 'news_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NewsListScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFEFF3FE),
      body: Center(
        child: Text(
          'News',
          style: TextStyle(
            color: Color(0xFF3366FF), 
            fontSize: 42,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
          ),
        ),
      ),
    );
  }
}