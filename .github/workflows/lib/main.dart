import 'package:flutter/material.dart';

void main() {
  runApp(const AvaLuxeApp());
}

class AvaLuxeApp extends StatelessWidget {
  const AvaLuxeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ava Luxe',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ava Luxe')),
      body: const Center(
        child: Text(
          'Hello from Ava Luxe 👋\nThis was built in GitHub Actions!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
