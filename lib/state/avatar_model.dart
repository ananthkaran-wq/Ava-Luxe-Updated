import 'package:flutter/material.dart';

class Garment {
  final IconData icon;
  const Garment(this.icon);
}

class Look {
  final Garment top;
  final Garment bottom;
  final IconData icon;
  const Look({required this.top, required this.bottom, required this.icon});
}

class AvatarModel {
  final Garment top;
  final Garment bottom;
  const AvatarModel({required this.top, required this.bottom});

  AvatarModel applyLook(Look l) => AvatarModel(top: l.top, bottom: l.bottom);

  static AvatarModel demo() => const AvatarModel(
        top: Garment(Icons.emoji_people),
        bottom: Garment(Icons.straighten),
      );

  static const demoLooks = <Look>[
    Look(top: Garment(Icons.dress), bottom: Garment(Icons.straighten), icon: Icons.dress),
    Look(top: Garment(Icons.blender), bottom: Garment(Icons.straighten), icon: Icons.coat_check),
    Look(top: Garment(Icons.checkroom), bottom: Garment(Icons.straighten), icon: Icons.checkroom),
    Look(top: Garment(Icons.roller_skating), bottom: Garment(Icons.straighten), icon: Icons.roller_skating),
    Look(top: Garment(Icons.tshirt), bottom: Garment(Icons.straighten), icon: Icons.tshirt),
    Look(top: Garment(Icons.sports_martial_arts), bottom: Garment(Icons.straighten), icon: Icons.sports_martial_arts),
  ];
}
