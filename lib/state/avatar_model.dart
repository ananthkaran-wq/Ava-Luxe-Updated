import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AvatarModel extends ChangeNotifier {
  String _name = 'Ava';
  String get name => _name;

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    _name = p.getString('avatarName') ?? 'Ava';
    notifyListeners();
  }

  Future<void> setName(String v) async {
    _name = v;
    final p = await SharedPreferences.getInstance();
    await p.setString('avatarName', v);
    notifyListeners();
  }
}
