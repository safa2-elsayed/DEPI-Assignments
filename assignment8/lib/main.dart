import 'package:flutter/material.dart';
import 'package:assignment7/screens/main_wrapper.dart';

void main() {
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery',
      theme: ThemeData(
        primaryColor: const Color(0xFFD92D2D),
        scaffoldBackgroundColor: const Color(0xFFF5F5F8),
        useMaterial3: true,
      ),
      home: const MainScreenWrapper(),
    );
  }
}
