import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPreferences {
  static const String _tokenKey = 'auth_token';
  static const String _emailKey = 'user_email';
  static const String _firstTimeKey = 'is_first_time';
  static late SharedPreferences _sharedPreferences;

  AuthSharedPreferences._();

  static AuthSharedPreferences? _authSharedPreferences;

  static Future<AuthSharedPreferences> init() async {
    if (_authSharedPreferences == null) {
      _authSharedPreferences = AuthSharedPreferences._();
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _authSharedPreferences!;
  }

  static Future<void> saveToken(String token) async {
    await _sharedPreferences.setString(_tokenKey, token);
  }

  static String? getToken() {
    return _sharedPreferences.getString(_tokenKey);
  }

  static Future<void> saveEmail(String email) async {
    await _sharedPreferences.setString(_emailKey, email);
  }

  static String? getEmail() {
    return _sharedPreferences.getString(_emailKey);
  }

  static Future<void> clearAuth() async {
    await _sharedPreferences.remove(_tokenKey);
    await _sharedPreferences.remove(_emailKey);
  }

  static bool isLoggedIn() {
    return _sharedPreferences.getString(_tokenKey) != null;
  }
  static Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstTimeKey) ?? true;
  }
  static Future<void> setFirstTime(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTimeKey, value);
  }
}

