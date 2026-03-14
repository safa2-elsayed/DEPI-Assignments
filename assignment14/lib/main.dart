import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/hotel_bloc.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Hotel Booking',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1975D2),
          brightness: Brightness.light,
        ),
        fontFamily: 'WorkSans',
      ),
      home: BlocProvider(
        create: (context) => HotelBloc(),
        child: const HomePage(),
      ),
    );
  }
}
