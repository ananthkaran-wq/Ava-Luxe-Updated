import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'state/app_settings.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppSettings(),
      child: const AvaApp(),
    ),
  );
}

class AvaApp extends StatelessWidget {
  const AvaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    final base = ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xFF5D56A6),
      fontFamily: 'Handjet', // or your current google_fonts choice
    );

    return MaterialApp(
      title: 'Ava Luxe',
      debugShowCheckedModeBanner: false,
      theme: base,
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5D56A6),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: settings.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
