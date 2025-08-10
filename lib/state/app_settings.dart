import 'package:flutter/foundation.dart';

class AppSettings extends ChangeNotifier {
  bool notifications = true;
  bool darkMode = false;
  int? selectedLook; // 0..3

  void toggleNotifications(bool v) {
    notifications = v;
    notifyListeners();
  }

  void toggleDarkMode(bool v) {
    darkMode = v;
    notifyListeners();
  }

  void selectLook(int i) {
    selectedLook = i;
    notifyListeners();
  }
}
