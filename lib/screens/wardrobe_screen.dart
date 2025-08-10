import 'package:flutter/material.dart';
import '../state/avatar_model.dart';
import '../widgets/avatar_view.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = AvatarModel.demoLooks;
    return Scaffold(
      appBar: AppBar(title: const Text('Wardrobe')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: .9),
        itemCount: items.length,
        itemBuilder: (c, i) {
          final look = items[i];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () {
                final avatar = AvatarModel.demo().applyLook(look);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => Scaffold(
                    appBar: AppBar(title: Text('Look #${i + 1}')),
                    body: Center(child: AvatarView(avatar: avatar, size: 260)),
                  ),
                ));
              },
              child: Column(
                children: [
                  Expanded(child: Center(child: Icon(look.icon, size: 96))),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('Look #${i + 1}'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
