

import 'package:shared_preferences/shared_preferences.dart';

class ShearedprefService {
  
static late SharedPreferences shearedPrefs;
  static bool _initialized = false;

  static Future<void> _initialize() async {
    shearedPrefs = await SharedPreferences.getInstance();
  }

  static Future<void> initialize() async {
    if (!_initialized) {
      await _initialize();
      _initialized = true;
    }
  }

  //set  user Logged
   static Future<void> setUserLoggedIn(bool value) async {
    if (!_initialized) {
      await initialize();
    }
    await shearedPrefs.setBool('userLoggedIn', value);
  }
  

  //get user Logged
  static bool? getUserLoggedIn() {
    if (!_initialized) {
      throw Exception("ShearedprefService is not initialized");
    }
    return shearedPrefs.getBool('userLoggedIn');
  }




 //set  intro Screen
   static Future<void> setUserTpe(String value) async {
    if (!_initialized) {
      await initialize();
    }
    await shearedPrefs.setString('userTpe', value);
  }
  

  //get intro Screen
  static String? getUserTpe() {
    if (!_initialized) {
      throw Exception("ShearedprefService is not initialized");
    }
    return shearedPrefs.getString('userTpe');
  }




   //set  intro Screen
   static Future<void> setUserIDStore(String value) async {
    if (!_initialized) {
      await initialize();
    }
    await shearedPrefs.setString('userIdStore', value);
  }
  

  //get intro Screen
  static String? getUserIDStore() {
    if (!_initialized) {
      throw Exception("ShearedprefService is not initialized");
    }
    return shearedPrefs.getString('userIdStore');
  }




   //set  Admin Password 
   static Future<void> setAdminPassword(String value) async {
    if (!_initialized) {
      await initialize();
    }
    await shearedPrefs.setString('adminPassword', value);
    
  }
  

  //get Admin Password 
  static String? getAdminPassword() {
    if (!_initialized) {
      throw Exception("ShearedprefService is not initialized");
    }
    return shearedPrefs.getString('adminPassword');
  }

}