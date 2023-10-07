import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kava_beats_app/Constants/colors.dart';
import 'package:kava_beats_app/Constants/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  final ThemePreferences _themePreferences = ThemePreferences();
  ThemeProvider() {
    _initTheme();
  }

  void _initTheme() async {
    themeMode = await _themePreferences.getThemeMode();
    notifyListeners();
  }

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) async {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    await _themePreferences.setThemeMode(themeMode);
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    backgroundColor: Colors.grey.shade900,
    fontFamily: "Roboto",
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF363a3a),
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white)),
    scaffoldBackgroundColor: Colors.grey.shade900,
    splashColor: primaryClr,
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.dark(),
    toggleableActiveColor: Colors.white,
    cardColor: const Color(0xFF363a3a),
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      headline3: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      headline5: TextStyle(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      headline6: TextStyle(color: Colors.white, fontSize: 10),
      bodyText1: TextStyle(color: Colors.white, fontSize: 18),
      bodyText2: TextStyle(color: Colors.white, fontSize: 14),
    ),
    iconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    backgroundColor: primaryClr,
    fontFamily: "Roboto",
    appBarTheme: AppBarTheme(
        backgroundColor: primaryClr,
        titleTextStyle: const TextStyle(color: Colors.white),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white)),
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.white,
    primaryColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    toggleableActiveColor: primaryClr,
    cardColor: Colors.white,
    textTheme: const TextTheme(
      headline1: TextStyle(
          color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
      headline3: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      headline4: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      headline5: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      headline6: TextStyle(color: Colors.black, fontSize: 10),
      bodyText1: TextStyle(color: Colors.black, fontSize: 18),
      bodyText2: TextStyle(color: Colors.black, fontSize: 14),
    ),
    iconTheme: IconThemeData(color: primaryClr, opacity: 0.8),
  );
}
