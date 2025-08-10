import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../state/app_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppSettings>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            value: s.darkMode,
            onChanged: (v) => s.setDarkMode(v),
            title: const Text('Dark mode'),
          ),
          ListTile(
            title: const Text('Text size'),
            subtitle: Text('${(s.textScale * 100).round()}%'),
            trailing: SizedBox(
              width: 200,
              child: Slider(
                value: s.textScale,
                min: 0.8, max: 1.4, divisions: 6,
                onChanged: (v) => s.setTextScale(double.parse(v.toStringAsFixed(2))),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              // The AuthGate in main.dart will route back to SignInScreen automatically.
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed out')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
