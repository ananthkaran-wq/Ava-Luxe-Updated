import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: const Text('Ava Luxe'),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome ✨',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        )),
                const SizedBox(height: 8),
                Text(
                  'Build your avatar, plan outfits, and chat. This is v0.1 — a stable shell we can extend quickly.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 20),
                _FeatureCard(
                  title: 'Create your Avatar',
                  subtitle: 'Open the Wardrobe and design your look.',
                  icon: Icons.face_retouching_natural,
                  tint: cs.primaryContainer,
                ),
                const SizedBox(height: 12),
                _FeatureCard(
                  title: 'Chat (preview)',
                  subtitle: 'A simple chat UI to hook AI later.',
                  icon: Icons.chat_bubble_outline,
                  tint: cs.secondaryContainer,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color tint;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.tint,
  });

  @override
  Widget build(BuildContext context) {
    final onTint = ThemeData.estimateBrightnessForColor(tint) == Brightness.dark
        ? Colors.white
        : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: onTint.withOpacity(.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 28, color: onTint),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: onTint,
                        )),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: onTint.withOpacity(.85)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
