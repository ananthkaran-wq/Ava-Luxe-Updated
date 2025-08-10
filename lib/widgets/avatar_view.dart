import 'package:flutter/material.dart';
import '../state/avatar_model.dart';

class AvatarView extends StatelessWidget {
  final AvatarModel avatar;
  final double size;
  const AvatarView({super.key, required this.avatar, this.size = 200});

  @override
  Widget build(BuildContext context) {
    // Very simple composed avatar (placeholders)
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Icon(Icons.face_3, size: size * .45),
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(avatar.top.icon, size: size * .35),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Icon(avatar.bottom.icon, size: size * .35),
          ),
        ],
      ),
    );
  }
}
