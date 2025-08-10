import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_tts/flutter_tts.dart';

const String appTitle = 'Ava Luxe';
const String appShareText = 'Check out the Ava Luxe app!';
const String prefDarkMode = 'pref_dark_mode';

// TODO: put your site here (https://...).
const String appUrl = 'https://flutter.dev';

void main() => runApp(const AvaLuxeApp());

class AvaLuxeApp extends StatefulWidget {
  const AvaLuxeApp({super.key});
  @override
  State<AvaLuxeApp> createState() => _AvaLuxeAppState();
}

class _AvaLuxeAppState extends State<AvaLuxeApp> {
  bool _dark = false;
  bool _loadingPrefs = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final sp = await SharedPreferences.getInstance();
    setState(() {
      _dark = sp.getBool(prefDarkMode) ?? false;
      _loadingPrefs = false;
    });
  }

  Future<void> _toggleTheme() async {
    final sp = await SharedPreferences.getInstance();
    setState(() => _dark = !_dark);
    await sp.setBool(prefDarkMode, _dark);
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingPrefs) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      themeMode: _dark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: MainScaffold(
        onShare: () => Share.share(appShareText),
        onToggleTheme: _toggleTheme,
        dark: _dark,
      ),
    );
  }
}

class MainScaffold extends StatefulWidget {
  final VoidCallback onShare;
  final VoidCallback onToggleTheme;
  final bool dark;

  const MainScaffold({
    super.key,
    required this.onShare,
    required this.onToggleTheme,
    required this.dark,
  });

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeTab(),
      const WebTab(),
      const VoiceTab(),
      SettingsTab(
        dark: widget.dark,
        onToggleTheme: widget.onToggleTheme,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
        actions: [
          IconButton(
            tooltip: 'Share',
            icon: const Icon(Icons.share),
            onPressed: widget.onShare,
          ),
        ],
      ),
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.public_outlined), selectedIcon: Icon(Icons.public), label: 'Web'),
          NavigationDestination(icon: Icon(Icons.record_voice_over_outlined), selectedIcon: Icon(Icons.record_voice_over), label: 'Voice'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: const [
        Icon(Icons.spa, size: 72),
        SizedBox(height: 16),
        Text('Welcome to Ava Luxe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
        Text('Use the tabs below to browse, speak, and tweak settings.', textAlign: TextAlign.center),
      ]),
    );
  }
}

class WebTab extends StatefulWidget {
  const WebTab({super.key});
  @override
  State<WebTab> createState() => _WebTabState();
}

class _WebTabState extends State<WebTab> {
  late final WebViewController _controller;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _loading = true),
          onPageFinished: (_) => setState(() => _loading = false),
        ),
      )
      ..loadRequest(Uri.parse(appUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      WebViewWidget(controller: _controller),
      if (_loading)
        const Positioned.fill(
          child: ColoredBox(
            color: Colors.transparent,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
    ]);
  }
}

class VoiceTab extends StatefulWidget {
  const VoiceTab({super.key});
  @override
  State<VoiceTab> createState() => _VoiceTabState();
}

class _VoiceTabState extends State<VoiceTab> {
  final _controller = TextEditingController(text: 'Hello from Ava Luxe!');
  final _tts = FlutterTts();
  bool _speaking = false;

  Future<void> _speak() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.speak(_controller.text);
    setState(() => _speaking = true);
    _tts.setCompletionHandler(() => setState(() => _speaking = false));
    _tts.setCancelHandler(() => setState(() => _speaking = false));
    _tts.setErrorHandler((_) => setState(() => _speaking = false));
  }

  Future<void> _stop() async {
    await _tts.stop();
    setState(() => _speaking = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text('Say something', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          minLines: 2,
          maxLines: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Type text to speak…',
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: _speaking ? null : _speak,
          icon: const Icon(Icons.play_arrow),
          label: const Text('Speak'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _speaking ? _stop : null,
          icon: const Icon(Icons.stop),
          label: const Text('Stop'),
        ),
      ]),
    );
  }
}

class SettingsTab extends StatelessWidget {
  final bool dark;
  final VoidCallback onToggleTheme;
  const SettingsTab({super.key, required this.dark, required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Dark mode'),
          value: dark,
          onChanged: (_) => onToggleTheme(),
        ),
        const ListTile(
          title: Text('Version'),
          subtitle: Text('1.0.0'),
        ),
      ],
    );
  }
}
