import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  bool darkMode = false;
  double textScale = 1.0;

  Future<void> load() async {
    final sp = await SharedPreferences.getInstance();
    darkMode = sp.getBool('darkMode') ?? false;
    textScale = sp.getDouble('textScale') ?? 1.0;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    darkMode = value;
    final sp = await SharedPreferences.getInstance();
    await sp.setBool('darkMode', value);
    notifyListeners();
  }

  Future<void> setTextScale(double value) async {
    textScale = value;
    final sp = await SharedPreferences.getInstance();
    await sp.setDouble('textScale', value);
    notifyListeners();
  }
}
