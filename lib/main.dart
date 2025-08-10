import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/wardrobe_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AvaApp());
}

class AvaApp extends StatefulWidget {
  const AvaApp({super.key});
  @override
  State<AvaApp> createState() => _AvaAppState();
}

class _AvaAppState extends State<AvaApp> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomeScreen(),
      ChatScreen(),
      WardrobeScreen(),
      SettingsScreen(),
    ];

    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF6C5CE7),
      useMaterial3: true,
      textTheme: GoogleFonts.caveatTextTheme(),
    );

    return MaterialApp(
      title: 'Ava Luxe',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: Scaffold(
        body: pages[_tab],
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: (i) => setState(() => _tab = i),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
            NavigationDestination(icon: Icon(Icons.checkroom_outlined), label: 'Wardrobe'),
            NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}
