import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return ListView(
      children: [
        SwitchListTile(
          title: const Text('Notifications'),
          subtitle: const Text('Receive updates from Ava'),
          value: settings.notifications,
          onChanged: (v) => context.read<AppSettings>().toggleNotifications(v),
        ),
        SwitchListTile(
          title: const Text('Dark mode'),
          value: settings.darkMode,
          onChanged: (v) => context.read<AppSettings>().toggleDarkMode(v),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('About'),
          subtitle: Text('Ava Luxe • demo build'),
        ),
      ],
    );
  }
}
