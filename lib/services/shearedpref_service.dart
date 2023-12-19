import 'package:shared_preferences/shared_preferences.dart';

class ShearedprefService {
  // static bool _initialized = false;

  // static Future<void> _initialize() async {
  //   shearedPrefs = await SharedPreferences.getInstance();
  // }

  // static Future<void> initialize() async {
  //   if (!_initialized) {
  //     await _initialize();
  //     _initialized = true;
  //   }
  // }

  //set  user Logged
  static Future<void> setUserLoggedIn(bool value) async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();
    await shearedPrefs.setBool('userLoggedIn', value);
  }

  //get user Logged
  static getUserLoggedIn() async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();

    return shearedPrefs.getBool('userLoggedIn');
  }

  //set  intro Screen
  static Future<void> setUserTpe(String value) async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();

    await shearedPrefs.setString('userTpe', value);
  }

  //get intro Screen
  static getUserTpe() async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();

    return shearedPrefs.getString('userTpe');
  }

  //set  intro Screen
  static Future<void> setUserIDStore(String value) async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();

    await shearedPrefs.setString('userIdStore', value);
  }

  //get intro Screen
  static getUserIDStore() async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();

    return shearedPrefs.getString('userIdStore');
  }

  //set  Admin Password
  static Future<void> setuserPassword(String value) async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();

    await shearedPrefs.setString('adminPassword', value);
  }

  //get Admin Password
  static getuserPassword() async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();

    return shearedPrefs.getString('adminPassword');
  }

  //set  Admin Password
  static Future<void> setuseremail(String value) async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();

    await shearedPrefs.setString('userEmail', value);
  }

  //get Admin Password
  static getuseremail() async {
    SharedPreferences shearedPrefs = await SharedPreferences.getInstance();

    return shearedPrefs.getString('userEmail');
  }
}
