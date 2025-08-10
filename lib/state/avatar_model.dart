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

/// Very small demo state for the wardrobe/avatar.
class AvatarModel extends ChangeNotifier {
  // Use icons that actually exist in Material Icons.
  // (There is no Icons.dress or Icons.tshirt.)
  final List<Look> _looks = const [
    Look(
      top: Garment(Icons.checkroom),     // clothing hanger
      bottom: Garment(Icons.straighten), // measuring line
      icon: Icons.checkroom,
    ),
    Look(
      top: Garment(Icons.blender),       // just a fun placeholder
      bottom: Garment(Icons.straighten),
      icon: Icons.inventory_2,           // a simple box icon
    ),
    Look(
      top: Garment(Icons.emoji_people),  // person silhouette
      bottom: Garment(Icons.straighten),
      icon: Icons.shopping_bag,          // bag icon
    ),
    Look(
      top: Garment(Icons.checkroom),
      bottom: Garment(Icons.straighten),
      icon: Icons.checkroom,
    ),
    Look(
      top: Garment(Icons.emoji_people),
      bottom: Garment(Icons.straighten),
      icon: Icons.shopping_bag,
    ),
    Look(
      top: Garment(Icons.checkroom),
      bottom: Garment(Icons.straighten),
      icon: Icons.checkroom,
    ),
  ];

  int _selectedIndex = 0;

  List<Look> get looks => _looks;
  int get selectedIndex => _selectedIndex;
  Look get selectedLook => _looks[_selectedIndex];

  void select(int index) {
    if (index < 0 || index >= _looks.length) return;
    _selectedIndex = index;
    notifyListeners();
  }
}
