import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/avatar_model.dart';
import '../widgets/avatar_view.dart';

class WardrobeScreen extends StatelessWidget {
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final a = context.watch<AvatarModel>();

    return LayoutBuilder(builder: (context, c) {
      final wide = c.maxWidth > 640;
      final controls = _Controls(a: a);
      final preview  = const AvatarView(size: 220);

      return Padding(
        padding: const EdgeInsets.all(16),
        child: wide
            ? Row(
                children: [
                  Expanded(child: Center(child: preview)),
                  const SizedBox(width: 24),
                  Expanded(child: controls),
                ],
              )
            : ListView(
                children: [
                  const SizedBox(height: 16),
                  Center(child: preview),
                  const SizedBox(height: 24),
                  controls,
                ],
              ),
      );
    });
  }
}

class _Controls extends StatelessWidget {
  const _Controls({required this.a});
  final AvatarModel a;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SwatchRow(
          label: 'Skin',
          colors: const [
            Color(0xFFFFE0BD), Color(0xFFFFD7B5), Color(0xFFF1C27D),
            Color(0xFFE0AC69), Color(0xFFC68642), Color(0xFF8D5524),
          ],
          onPick: a.setSkin,
          current: a.skin,
        ),
        const SizedBox(height: 16),
        _SwatchRow(
          label: 'Hair',
          colors: const [
            Color(0xFF2E2E2E), Color(0xFF38220F), Color(0xFF704214),
            Color(0xFFAD8A64), Color(0xFF4A2C2A), Color(0xFF000000),
          ],
          onPick: a.setHair,
          current: a.hair,
        ),
        const SizedBox(height: 16),
        _SwatchRow(
          label: 'Shirt',
          colors: const [
            Color(0xFF7C4DFF), Color(0xFF2196F3), Color(0xFF00BCD4),
            Color(0xFFFF5252), Color(0xFFFFC107), Color(0xFF4CAF50),
          ],
          onPick: a.setShirt,
          current: a.shirt,
        ),
      ],
    );
  }
}

class _SwatchRow extends StatelessWidget {
  const _SwatchRow({
    required this.label,
    required this.colors,
    required this.onPick,
    required this.current,
  });

  final String label;
  final List<Color> colors;
  final void Function(Color) onPick;
  final Color current;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: colors.map((c) {
            final sel = c.value == current.value;
            return GestureDetector(
              onTap: () => onPick(c),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: c,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: sel ? Theme.of(context).colorScheme.primary : Colors.black12,
                    width: sel ? 3 : 1,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
