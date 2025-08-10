import 'package:flutter/material.dart';
import '../widgets/avatar_view.dart';
import '../state/avatar_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final avatar = AvatarModel.demo();
    return Scaffold(
      appBar: AppBar(title: const Text('Ava Luxe')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: Center(
                child: AvatarView(avatar: avatar, size: 240),
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              icon: const Icon(Icons.checkroom_outlined),
              label: const Text('Try outfits'),
              onPressed: () => Navigator.pushNamed(context, '/wardrobe'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
