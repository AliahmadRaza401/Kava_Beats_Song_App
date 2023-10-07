import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const String _themeModeKey = 'themeMode';

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_themeModeKey, _themeModeToInt(themeMode));
  }

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeInt = prefs.getInt(_themeModeKey) ?? 1;
    return _intToThemeMode(themeModeInt);
  }

  int _themeModeToInt(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 0;
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
    }
  }

  ThemeMode _intToThemeMode(int themeModeInt) {
    switch (themeModeInt) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }
}
