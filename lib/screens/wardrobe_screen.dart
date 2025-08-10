import 'package:flutter/material.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(12, (i) => 'Look #${i + 1}');
    return Scaffold(
      appBar: AppBar(title: const Text('Wardrobe')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.82,
        ),
        itemCount: items.length,
        itemBuilder: (c, i) => Card(
          clipBehavior: Clip.antiAlias,
          elevation: 1,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(c).showSnackBar(
                SnackBar(content: Text('Opening ${items[i]}…')),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(c).colorScheme.surfaceVariant,
                    alignment: Alignment.center,
                    child: Icon(Icons.image, size: 48, color: Theme.of(c).hintColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(items[i], style: Theme.of(c).textTheme.bodyMedium),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
