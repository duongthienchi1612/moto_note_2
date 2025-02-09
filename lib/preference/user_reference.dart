import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../utilities/static_var.dart';

class UserReference {
  // get
  Future<String?> getCurrentUserId() => getLocal(PreferenceKey.currentUserId);
  Future<String?> getCurrentUserName() => getLocal(PreferenceKey.currentUserName);
  Future<String?> getLanguage() => getLocal('${StaticVar.currentUserId}_${PreferenceKey.language}');
  Future<int?> getCurrentKm() => getLocal('${StaticVar.currentUserId}_${PreferenceKey.currentKm}');

  // set
  Future setCurrentUserId(String value) => setLocal(PreferenceKey.currentUserId, value);
  Future setCurrentUserName(String value) => setLocal(PreferenceKey.currentUserName, value);
  Future setLanguage(String value) => setLocal('${StaticVar.currentUserId}_${PreferenceKey.language}', value);
  Future setCurrentKm(int value) => setLocal('${StaticVar.currentUserId}_${PreferenceKey.currentKm}', value);

  Future setLocal(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  Future<T?> getLocal<T>(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return prefs.get(key) as T?;
    }
    return null;
  }
}
