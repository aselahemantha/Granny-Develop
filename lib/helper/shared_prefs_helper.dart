import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String _lastLoginKey = "lastLoginTime";

  static Future<void> saveLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastLoginKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final int? lastLoginTime = prefs.getInt(_lastLoginKey);
    final int currentTime = DateTime.now().millisecondsSinceEpoch;

    if (lastLoginTime == null) return false;

    return (currentTime - lastLoginTime) < (12 * 60 * 60 * 1000); // 12 hours
  }

  static Future<void> clearLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_lastLoginKey);
  }
}
