import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _token = "";
  static int _themeMode = 1;
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

  static int get themeMode {
    return _prefs.getInt("themeMode") ?? _themeMode;
  }

  static set themeMode(int value) {
    _themeMode = value;
    _prefs.setInt("themeMode", value);
  }

  static int get color {
    return _prefs.getInt("color") ?? _colorValue;
  }

  static set color(int value) {
    _colorValue = value;
    _prefs.setInt("color", value);
  }
}
