import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  bool _darkMode = false;
  double _textScale = 1.0;

  bool get darkMode => _darkMode;
  double get textScale => _textScale;

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    _darkMode = p.getBool('darkMode') ?? false;
    _textScale = p.getDouble('textScale') ?? 1.0;
    notifyListeners();
  }

  Future<void> setDarkMode(bool v) async {
    _darkMode = v;
    final p = await SharedPreferences.getInstance();
    await p.setBool('darkMode', v);
    notifyListeners();
  }

  Future<void> setTextScale(double v) async {
    _textScale = v;
    final p = await SharedPreferences.getInstance();
    await p.setDouble('textScale', v);
    notifyListeners();
  }
}
