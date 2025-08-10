import 'package:flutter/material.dart';

enum Top { tee, shirt, jacket }
enum Bottom { jeans, chinos, skirt }

class Look {
  final String id;
  final String label;
  final Top top;
  final Bottom bottom;

  const Look({
    required this.id,
    required this.label,
    required this.top,
    required this.bottom,
  });

  // Use icons that exist in Flutter 3.22.x
  IconData get iconData {
    // Pick one representative icon per look
    return Icons.checkroom; // generic “wardrobe / clothes” icon
  }

  IconData get topIcon {
    switch (top) {
      case Top.tee:
        return Icons.checkroom; // no tshirt icon in stable, use checkroom
      case Top.shirt:
        return Icons.checkroom_outlined;
      case Top.jacket:
        return Icons.hiking; // just a fun stand-in
    }
  }

  IconData get bottomIcon {
    switch (bottom) {
      case Bottom.jeans:
        return Icons.style; // “style” is available on stable
      case Bottom.chinos:
        return Icons.workspace_premium; // stand-in
      case Bottom.skirt:
        return Icons.style; // skirt icon doesn’t exist -> fallback
    }
  }
}

// Some sample looks so the Wardrobe isn’t empty
const sampleLooks = <Look>[
  Look(id: 'l1', label: 'Casual Tee + Jeans', top: Top.tee, bottom: Bottom.jeans),
  Look(id: 'l2', label: 'Smart Shirt + Chinos', top: Top.shirt, bottom: Bottom.chinos),
  Look(id: 'l3', label: 'Jacket + Jeans', top: Top.jacket, bottom: Bottom.jeans),
  Look(id: 'l4', label: 'Tee + Skirt', top: Top.tee, bottom: Bottom.skirt),
];
