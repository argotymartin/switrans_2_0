import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferencesWithCache _prefs;
  static String _token = "";
  static String _usuarioNombre = "";
  static int _themeMode = 1;
  static int _colorValue = 4282339765;
  static bool _isResetForm = true;
  static String _paquetes = "";
  static String _env = "";

  static Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{'token', 'usuarioNombre', 'themeMode', 'color', 'isResetForm', 'paquetes', 'env'},
      ),
    );
  }

  static String get token => _prefs.getString("token") ?? _token;

  static set token(String value) {
    _token = value;
    _prefs.setString("token", value);
  }

  static String get usuarioNombre => _prefs.getString("usuarioNombre") ?? _token;

  static set usuarioNombre(String value) {
    _usuarioNombre = value;
    _prefs.setString("usuarioNombre", _usuarioNombre);
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

  static String get paquetes => _prefs.getString("paquetes") ?? _paquetes;

  static set paquetes(String value) {
    _paquetes = value;
    _prefs.setString("paquetes", value);
  }

  static String get env => _prefs.getString("env") ?? _env;

  static set env(String value) {
    _env = value;
    _prefs.setString("env", value);
  }
}
