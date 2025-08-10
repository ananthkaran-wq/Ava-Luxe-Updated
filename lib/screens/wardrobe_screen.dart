import 'package:flutter/material.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(12, (i) => _Look(
      title: 'Look #${i + 1}',
      emoji: ['👗','🧥','👔','👚','👖','👟','🧣','👜','🕶️','💄','⌚','🧢'][i % 12],
    ));

    return Scaffold(
      appBar: AppBar(title: const Text('Wardrobe')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: .9),
        itemCount: items.length,
        itemBuilder: (c, i) {
          final look = items[i];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => ScaffoldMessenger.of(c)
                  .showSnackBar(SnackBar(content: Text('Selected ${look.title}'))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(look.emoji, style: const TextStyle(fontSize: 56)),
                  const SizedBox(height: 8),
                  Text(look.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Look {
  final String title;
  final String emoji;
  _Look({required this.title, required this.emoji});
}
