import 'package:flutter/material.dart';
import 'package:ava_luxe/state/avatar_model.dart';

/// Very simple avatar renderer that just shows two big icons:
/// one for the top and one for the bottom.
class AvatarView extends StatelessWidget {
  final AvatarModel avatar;
  final double size;
  const AvatarView({super.key, required this.avatar, this.size = 160});

  @override
  Widget build(BuildContext context) {
    final s = size;
    return SizedBox(
      width: s,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top icon
          Container(
            height: s * .55,
            alignment: Alignment.center,
            child: Icon(avatar.top.icon, size: s * .5),
          ),
          // Bottom icon
          Container(
            height: s * .35,
            alignment: Alignment.center,
            child: Icon(avatar.bottom.icon, size: s * .35),
          ),
        ],
      ),
    );
  }
}
