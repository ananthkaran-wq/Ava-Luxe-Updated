import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AvaLuxeApp());
}

class AvaLuxeApp extends StatelessWidget {
  const AvaLuxeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF6D5DF6));
    return MaterialApp(
      title: 'Ava Luxe',
      theme: ThemeData(
        colorScheme: scheme,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
