import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _token = "";
  static bool _isDarkMode = true;
  static int _colorValue = 4282339765;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get token {
    return _prefs.getString("token") ?? _token;
  }

  static set token(String value) {
    _token = value;
    _prefs.setString("token", value);
  }

  static bool get isDarkMode {
    return _prefs.getBool("isDarkMode") ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool("isDarkMode", value);
  }

  static int get color {
    return _prefs.getInt("color") ?? _colorValue;
  }

  static set color(int value) {
    _colorValue = value;
    _prefs.setInt("color", value);
  }
}
