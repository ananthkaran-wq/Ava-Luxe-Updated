import 'package:flutter/material.dart';

void main() => runApp(const AvaLuxeApp());

class AvaLuxeApp extends StatelessWidget {
  const AvaLuxeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ava Luxe',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFF6EFF6),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.local_florist, size: 96),
              SizedBox(height: 24),
              Text('Hello from Ava Luxe 👋',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
              SizedBox(height: 12),
              Text('Built by GitHub Actions', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
