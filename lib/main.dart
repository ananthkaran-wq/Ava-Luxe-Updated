import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/app_settings.dart';
import 'models/avatar_model.dart';
import 'screens/home_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/wardrobe_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = AppSettings();
  await settings.load();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => settings),
      ChangeNotifierProvider(create: (_) => AvatarModel()..load()),
    ],
    child: const AvaLuxeApp(),
  ));
}

class AvaLuxeApp extends StatelessWidget {
  const AvaLuxeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF7C4DFF),
      brightness: settings.darkMode ? Brightness.dark : Brightness.light,
      textTheme: GoogleFonts.caveatTextTheme(
        Theme.of(context).textTheme.apply(fontSizeFactor: settings.textScale),
      ),
    );

    return MaterialApp(
      title: 'Ava Luxe',
      theme: theme,
      home: const _NavShell(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _NavShell extends StatefulWidget {
  const _NavShell({super.key});
  @override
  State<_NavShell> createState() => _NavShellState();
}

class _NavShellState extends State<_NavShell> {
  int _index = 0;

  final _pages = const [
    HomeScreen(),
    WardrobeScreen(),
    ChatScreen(),
    SettingsScreen(),
  ];

  final _labels = const ['Home', 'Wardrobe', 'Chat', 'Settings'];
  final _icons  = const [Icons.home, Icons.checkroom, Icons.forum, Icons.settings];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_labels[_index])),
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: List.generate(_labels.length, (i) {
          return NavigationDestination(
            icon: Icon(_icons[i]),
            label: _labels[i],
          );
        }),
      ),
    );
  }
}
