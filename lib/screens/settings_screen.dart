import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.person_outline), title: Text('Account')),
          ListTile(leading: Icon(Icons.notifications_outlined), title: Text('Notifications')),
          ListTile(leading: Icon(Icons.privacy_tip_outlined), title: Text('Privacy')),
          ListTile(leading: Icon(Icons.info_outline), title: Text('About')),
        ],
      ),
    );
  }
}
