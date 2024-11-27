import 'package:flutter/material.dart';

class AccessibilitySettings extends ChangeNotifier {
  double _fontSize = 16.0;
  bool _dyslexiaFriendly = false;
  bool _highContrast = false;

  double get fontSize => _fontSize;
  bool get dyslexiaFriendly => _dyslexiaFriendly;
  bool get highContrast => _highContrast;

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
  }

  void toggleDyslexiaFriendly() {
    _dyslexiaFriendly = !_dyslexiaFriendly;
    notifyListeners();
  }

  void toggleHighContrast() {
    _highContrast = !_highContrast;
    notifyListeners();
  }
}
