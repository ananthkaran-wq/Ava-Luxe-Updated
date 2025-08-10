import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart' show ThemeHost; // <- for live theme

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
      theme: ThemeData(colorScheme: scheme, useMaterial3: true),
      home: ThemeHost(initial: scheme, child: const HomeScreen()),
    );
  }
}
