import 'package:shared_preferences/shared_preferences.dart';

// A small helper service wrapping SharedPreferences operations.
class SharedPrefsService {
  // Keys
  static const _kUsername = 'username';
  static const _kCounter = 'counter';
  static const _kDarkMode = 'isDarkMode';

  // Save username
  static Future<bool> setUsername(String username) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.setString(_kUsername, username);
    } catch (e) {
      // In production you might log this error
      return false;
    }
  }

  // Read username
  static Future<String?> getUsername() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_kUsername);
    } catch (e) {
      return null;
    }
  }

  // Counter
  static Future<bool> setCounter(int value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.setInt(_kCounter, value);
    } catch (e) {
      return false;
    }
  }

  static Future<int> getCounter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_kCounter) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  // Theme
  static Future<bool> setDarkMode(bool isDark) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.setBool(_kDarkMode, isDark);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> getDarkMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_kDarkMode) ?? false;
    } catch (e) {
      return false;
    }
  }
}
