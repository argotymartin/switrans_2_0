import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _token = "";
  static int _themeMode = 1;
  static int _colorValue = 4282339765;
  static bool _isResetForm = true;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String get token => _prefs.getString("token") ?? _token;

  static set token(String value) {
    _token = value;
    _prefs.setString("token", value);
  }

  static int get themeMode => _prefs.getInt("themeMode") ?? _themeMode;

  static set themeMode(int value) {
    _themeMode = value;
    _prefs.setInt("themeMode", value);
  }

  static int get color => _prefs.getInt("color") ?? _colorValue;

  static set color(int value) {
    _colorValue = value;
    _prefs.setInt("color", value);
  }

  static bool get isResetForm => _prefs.getBool("isResetForm") ?? _isResetForm;

  static set isResetForm(bool value) {
    _isResetForm = value;
    _prefs.setBool("isResetForm", value);
  }
}
