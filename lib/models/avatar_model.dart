import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarModel extends ChangeNotifier {
  // very simple avatar knobs
  Color skin = const Color(0xFFFFD7B5);
  Color hair = const Color(0xFF38220F);
  Color shirt = const Color(0xFF7C4DFF);

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    skin  = _readColor(sp, 'skin')  ?? skin;
    hair  = _readColor(sp, 'hair')  ?? hair;
    shirt = _readColor(sp, 'shirt') ?? shirt;
    notifyListeners();
  }

  Future<void> setSkin(Color c) async => _set('skin', c);
  Future<void> setHair(Color c) async => _set('hair', c);
  Future<void> setShirt(Color c) async => _set('shirt', c);

  Future<void> _set(String key, Color c) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(key, c.value);
    switch (key) {
      case 'skin': skin = c; break;
      case 'hair': hair = c; break;
      case 'shirt': shirt = c; break;
    }
    notifyListeners();
  }

  Color? _readColor(SharedPreferences sp, String key) {
    final v = sp.getInt(key);
    return v == null ? null : Color(v);
    }
}
