import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            value: notifications,
            onChanged: (v) => setState(() => notifications = v),
            title: const Text('Notifications'),
            subtitle: const Text('Receive updates from Ava'),
          ),
          SwitchListTile(
            value: darkMode,
            onChanged: (v) {
              setState(() => darkMode = v);
              // live theme demo (session only)
              final scheme = v
                  ? const ColorScheme.dark()
                  : ColorScheme.fromSeed(seedColor: const Color(0xFF6D5DF6));
              final app = context.findAncestorStateOfType<_ThemeHostState>();
              app?.setScheme(scheme);
            },
            title: const Text('Dark mode'),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About'),
            subtitle: Text('Ava Luxe • demo build'),
          ),
        ],
      ),
    );
  }
}

/// Small helper to toggle theme without adding storage deps
class ThemeHost extends StatefulWidget {
  final Widget child;
  final ColorScheme initial;
  const ThemeHost({super.key, required this.child, required this.initial});
  @override
  State<ThemeHost> createState() => _ThemeHostState();
}

class _ThemeHostState extends State<ThemeHost> {
  late ColorScheme _scheme = widget.initial;
  void setScheme(ColorScheme s) => setState(() => _scheme = s);

  @override
  Widget build(BuildContext context) {
    return Theme(data: ThemeData(colorScheme: _scheme, useMaterial3: true), child: widget.child);
  }
}
