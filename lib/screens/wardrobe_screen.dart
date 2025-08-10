import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_settings.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({super.key});

  static const _looks = [
    ('Casual Tee + Jeans', Icons.emoji_people),
    ('Smart Shirt + Chinos', Icons.workspace_premium_outlined),
    ('Jacket + Jeans', Icons.hiking),
    ('Tee + Skirt', Icons.style_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: _looks.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.0),
        itemBuilder: (c, i) {
          final (title, icon) = _looks[i];
          final selected = settings.selectedLook == i;

          return Card(
            elevation: selected ? 2 : 0,
            shape: RoundedRectangleBorder(
              side: selected ? BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2) : BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () {
                context.read<AppSettings>().selectLook(i);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected "$title"')),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 64),
                  const SizedBox(height: 12),
                  Text(title, textAlign: TextAlign.center),
                  if (selected) ...[
                    const SizedBox(height: 8),
                    const Icon(Icons.check_circle, size: 20),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
