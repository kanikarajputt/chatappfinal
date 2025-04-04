import 'package:flutter/material.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'dark_mode.dart';


class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set theme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
  void toggleTheme(){
    if (_themeData == lightMode) {
      theme = darkMode;
    } else {
      theme = lightMode;
    }
  }
}