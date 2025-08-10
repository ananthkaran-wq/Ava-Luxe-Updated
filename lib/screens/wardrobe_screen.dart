import 'package:flutter/material.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(12, (i) => 'Look #${i+1}');
    return Scaffold(
      appBar: AppBar(title: const Text('Wardrobe')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.9),
        itemCount: items.length,
        itemBuilder: (c, i) => Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            child: Column(
              children: [
                Expanded(child: Container(color: Theme.of(context).colorScheme.surfaceVariant)),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(items[i]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
