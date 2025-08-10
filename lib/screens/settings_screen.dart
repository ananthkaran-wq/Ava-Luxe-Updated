import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppSettings>();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SwitchListTile(
          title: const Text('Dark mode'),
          value: s.darkMode,
          onChanged: (v) => s.setDarkMode(v),
        ),
        const SizedBox(height: 8),
        ListTile(
          title: const Text('Text size'),
          subtitle: Text('${(s.textScale * 100).round()}%'),
          trailing: SizedBox(
            width: 180,
            child: Slider(
              value: s.textScale,
              onChanged: (v) => s.setTextScale(v),
              divisions: 6,
              min: 0.8,
              max: 1.4,
              label: '${(s.textScale * 100).round()}%',
            ),
          ),
        ),
        const Divider(height: 32),
        const Text('About', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Ava Luxe — sample app with Wardrobe, Chat, and Settings. Built via GitHub Actions.'),
      ],
    );
  }
}
