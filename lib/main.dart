import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/task_controller.dart';
import 'views/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TaskController())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        primaryColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
