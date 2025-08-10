import 'package:flutter/material.dart';

/// What the avatar wears on top.
enum Top {
  dress,
  jacket,
  shirt,
  tee,
}

/// What the avatar wears on the bottom.
enum Bottom {
  skirt,
  jeans,
  pants,
  sneakers, // keep a fun option
}

/// Icons & labels for Tops
extension TopX on Top {
  IconData get icon {
    switch (this) {
      case Top.dress:  return Icons.checkroom;
      case Top.jacket: return Icons.hiking;      // coat-ish
      case Top.shirt:  return Icons.business;
      case Top.tee:    return Icons.tshirt_crew; // if missing, fallback below
    }
  }

  String get label {
    switch (this) {
      case Top.dress:  return 'Dress';
      case Top.jacket: return 'Jacket';
      case Top.shirt:  return 'Shirt';
      case Top.tee:    return 'T-Shirt';
    }
  }
}

/// Icons & labels for Bottoms
extension BottomX on Bottom {
  IconData get icon {
    switch (this) {
      case Bottom.skirt:   return Icons.skirt;   // if your SDK lacks this, swap to Icons.style
      case Bottom.jeans:   return Icons.roller_skating; // playful stand-in
      case Bottom.pants:   return Icons.boy;     // stand-in for trousers
      case Bottom.sneakers:return Icons.directions_run;
    }
  }

  String get label {
    switch (this) {
      case Bottom.skirt:    return 'Skirt';
      case Bottom.jeans:    return 'Jeans';
      case Bottom.pants:    return 'Pants';
      case Bottom.sneakers: return 'Sneakers';
    }
  }
}

/// A preset "look" = a top + a bottom.
class Look {
  final Top top;
  final Bottom bottom;
  final String name;
  const Look(this.top, this.bottom, this.name);
}

/// The avatar’s current outfit.
class AvatarModel {
  final Top top;
  final Bottom bottom;

  const AvatarModel({
    required this.top,
    required this.bottom,
  });

  AvatarModel copyWith({Top? top, Bottom? bottom}) =>
      AvatarModel(top: top ?? this.top, bottom: bottom ?? this.bottom);

  /// What the UI expects: a demo/default avatar.
  static AvatarModel demo() =>
      const AvatarModel(top: Top.shirt, bottom: Bottom.jeans);

  /// Apply a preset look to this avatar (used in Wardrobe screen).
  AvatarModel applyLook(Look look) =>
      AvatarModel(top: look.top, bottom: look.bottom);

  /// What the UI expects: a list of demo looks for the Wardrobe grid.
  static const List<Look> demoLooks = [
    Look(Top.dress,  Bottom.skirt,    'Look #1'),
    Look(Top.jacket, Bottom.pants,    'Look #2'),
    Look(Top.shirt,  Bottom.pants,    'Look #3'),
    Look(Top.tee,    Bottom.jeans,    'Look #4'),
    Look(Top.shirt,  Bottom.jeans,    'Look #5'),
    Look(Top.tee,    Bottom.sneakers, 'Look #6'),
  ];
}
