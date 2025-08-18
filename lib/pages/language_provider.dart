import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  int _selectedLang = 0;

  int get selectedLang => _selectedLang;

  List<String> get langs => ["中文", "英文"];

  void changeLanguage(int newLang) {
    _selectedLang = newLang;
    notifyListeners(); // 通知所有监听者
  }
}
