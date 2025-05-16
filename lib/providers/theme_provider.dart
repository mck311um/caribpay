import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isSystemMode => _themeMode == ThemeMode.system;
  bool get isLightMode => _themeMode == ThemeMode.light;

  ThemeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'system';

    switch (themeString) {
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      case 'system':
      default:
        _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    String themeString;

    switch (themeMode) {
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.system:
        themeString = 'system';
    }

    await prefs.setString('themeMode', themeString);
  }

  void toggleThemeMode(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode(_themeMode);
    notifyListeners();
  }

  void setSystemTheme(bool isSystemMode) {
    _themeMode = isSystemMode ? ThemeMode.system : ThemeMode.dark;
    _saveThemeMode(_themeMode);
    notifyListeners();
  }

  void setDarkMode(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode(_themeMode);
    notifyListeners();
  }

  void setLightMode(bool isLightMode) {
    _themeMode = isLightMode ? ThemeMode.light : ThemeMode.dark;
    _saveThemeMode(_themeMode);
    notifyListeners();
  }
}
